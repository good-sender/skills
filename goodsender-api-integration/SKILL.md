---
name: goodsender-api-integration
description: Use when integrating the GoodSender email API into an app or service — obtaining and configuring an API key, verifying a sender domain, requesting recipient consent, and sending custom or transactional email over HTTP. Covers the Permission Loop, the Engagement Check, auth, error/quota handling, and the correct send flow.
license: Apache-2.0
---

# Integrating the GoodSender Email API

## Overview

GoodSender is a free, consent-based email service. Your app sends email over a small HTTP API. The defining rule that shapes every integration — GoodSender calls it **the Permission Loop**:

> **Custom email** is delivered **only to recipients who have granted consent** for your sending domain. You request consent once per recipient; GoodSender sends them a signed (un-forgeable) approve/reject prompt; only after they approve will `/v1/emails/send` deliver to them. Recipients without granted consent are silently counted as `declined`, not delivered.

The exception is **transactional templates** (OTP, order receipt, security alerts, etc.) via `/v1/emails/template`: a fixed catalogue of predefined messages that send instantly to any address, bypassing the Permission Loop entirely.

GoodSender is not a marketing or cold-outreach platform — you can only reach people who explicitly opted in. Design your integration around these two paths. Full endpoint/field details live in [references/api-reference.md](references/api-reference.md); this file is the workflow.

## Step 1 — Get an API key

1. Sign up at the GoodSender Console: https://goodsender.com (free).
2. Open the **API Keys** section and create a key.
3. Store it as a **server-side secret** (env var / secret manager) — e.g. `GOODSENDER_API_KEY`. Never ship it in client-side code, mobile apps, or a public repo; the key grants full send access for your workspace.

All requests authenticate with a bearer token:

```
Authorization: Bearer <YOUR_API_KEY>
```

Base URL: `https://api.goodsender.com` (use `https://api.dev.goodsender.com` for staging).

## Step 2 — Add and verify your sending domain

You can only send from a domain your workspace has verified. In the Console, add your domain and publish the DNS records it gives you (DKIM ×2, return-path CNAME, tracking CNAME). Your code can confirm readiness programmatically:

```
GET /v1/domains  →  each domain has verification.verified (overall) plus
                     per-record booleans (dkim1_verified, dkim2_verified,
                     return_path_verified, tracking_verified)
```

Gate your send logic on `verification.verified === true`. Until then, mail will be rejected with a "not allowed to send from this domain" error.

## Step 3 — Choose the right send path

| Your use case | Endpoint | Consent needed? |
|---------------|----------|-----------------|
| Custom email — newsletters, announcements, product updates, notifications to opted-in users | `POST /v1/emails/send` | Yes — recipient must have `granted` via the Permission Loop |
| Transactional — OTP/2FA codes, order receipts, security alerts (password/email changed), new-device alerts | `POST /v1/emails/template` | No — the Permission Loop is bypassed entirely (no consent, no prior registration) |

Don't push custom content through the transactional endpoint to skip the Permission Loop — that path only accepts the [fixed built-in templates](references/api-reference.md#post-v1emailstemplate) (link-free), so it can't carry arbitrary content.

## Step 4 — The Permission Loop (custom email)

For custom email, the per-recipient lifecycle is:

1. **Request consent** (`POST /v1/emails/consent`) when a user opts in (signup, "subscribe", etc.). GoodSender emails them; their status goes `pending → requested`, then `granted` or `denied` once they respond.
2. **Track status.** Either poll `GET /v1/emails` incrementally (filter `consentStatus=granted` and/or use `consentStatusUpdatedAfter` to sync only changes) and store consent state in your own DB, or check a single address with `GET /v1/emails/{email}`.
3. **Send** (`POST /v1/emails/send`) whenever you like. Don't pre-filter by your cached state alone — GoodSender enforces consent at send time and returns `{ sent, declined }`. Treat `declined` as "not yet consented or inactive," not as an error.

A `200` response does **not** mean everyone received the email — always inspect `sent` vs `declined`.

Consent is scoped to `(sender domain, recipient)` and is **shared across every API key in your workspace** — once a recipient approves, all sends from that domain go through. A grant for one domain does not extend to your other domains.

## Step 5 — Implement the client

One worked example (TypeScript / `fetch`; port the shape to any language). Keep all of this server-side.

```ts
const BASE = "https://api.goodsender.com";
const KEY = process.env.GOODSENDER_API_KEY!; // server-side secret

async function gs(path: string, init: RequestInit = {}) {
  const res = await fetch(BASE + path, {
    ...init,
    headers: {
      "Authorization": `Bearer ${KEY}`,
      "Content-Type": "application/json",
      ...(init.headers ?? {}),
    },
  });
  if (res.status === 429) {
    const retryAfter = Number(res.headers.get("Retry-After") ?? "60");
    throw new QuotaError(retryAfter); // back off, don't hammer
  }
  if (!res.ok) throw new Error(`GoodSender ${res.status}: ${await res.text()}`);
  return res.json();
}

// 1. Ask a new opt-in for consent (do this once, when the user subscribes).
await gs("/v1/emails/consent", {
  method: "POST",
  body: JSON.stringify({
    domain: "yourdomain.com",
    redirect_url: "https://yourapp.com/thanks-for-subscribing",
    emails: [{ email: "user@example.com", name: "Jane Doe" }],
  }),
});

// 2. Later, send to your list. Only granted+active recipients receive it.
const { sent, declined } = await gs("/v1/emails/send", {
  method: "POST",
  body: JSON.stringify({
    emails: [{
      from: { email: "news@yourdomain.com", name: "Your App" },
      to: [{ email: "user@example.com", name: "Jane Doe" }], // up to 1000 per email
      subject: "This month at Your App",
      markdown_content: "# Hello\n\nHere's what's new this month...",
      tracking: { opens: true, clicks: true },
    }],
  }),
});
console.log(`sent=${sent} declined=${declined}`);

// Transactional path — bypasses the Permission Loop, single recipient, sends to any address.
const { status } = await gs("/v1/emails/template", {
  method: "POST",
  body: JSON.stringify({
    from: { email: "auth@yourdomain.com", name: "Your App" },
    to: { email: "user@example.com" },
    subject: "Your verification code",
    template: { template_id: "otp_code",
      variables: { app_name: "Your App", otp_code: "482916", expiry_minutes: "10" } },
  }),
}); // status is always "sent" — transactional is not gated on consent
```

Quick `curl` equivalents for testing each endpoint are in [api-reference.md](references/api-reference.md).

## Operational rules

- **Quotas (429).** There are daily and monthly send quotas. On `429`, read the `Retry-After` header and the body (`kind`, `limit`, `used`, `resetAt`) and back off until reset — never tight-loop retries.
- **Retries.** `500`/`502` are safe to retry with backoff (consent creation is idempotent). `400`/`401`/`404` are not retryable — fix the request.
- **The Engagement Check (inactivity).** GoodSender tracks each recipient's engagement over time (stages `new → hot → warm → cooling → dormant → inactive`). After 120 days with no opens/clicks a `granted` recipient becomes `inactive` and is blocked from `/v1/emails/send` (counted under `declined`). To re-engage, call `/v1/emails/consent` again — it resets them to `pending` and sends a fresh consent email.
- **Workspace-wide suppression.** An unsubscribe or spam complaint suppresses that address **instantly across the whole workspace** — custom (`/v1/emails/send`) email to it is declined from then on, from any API key.
- **Transactional templates are link-free.** Their bodies contain no clickable links (an anti-phishing measure). Deliver codes/values in the body (e.g. an OTP the user types back in) and implement any click-through flow in your own app, not via a link in the email.
- **Batching.** Up to 1000 recipients per email and multiple emails per `send` request. Large attachments/recipient counts can return `413`.
- **No unsubscribe footers needed.** GoodSender appends required compliance footers automatically; don't add your own.
- **Scheduling.** `send_time` (unix seconds, ≤72h ahead) defers delivery; `0`/omitted sends immediately.

## Common mistakes

| Mistake | Reality |
|---------|---------|
| Treating a `200` as "everyone got it" | Check `sent` vs `declined`; `declined` = no granted consent (or inactive). |
| Sending custom email before requesting consent | Custom email to non-consented recipients is silently declined. Run the Permission Loop first. |
| Pushing custom content through `/v1/emails/template` | The transactional path only accepts the fixed built-in templates (link-free, single recipient). Use `/v1/emails/send` for custom email. |
| Expecting a reject to stop transactional email | A Permission Loop reject (`denied`) only blocks custom sends; transactional templates still deliver. |
| Sending from an unverified domain | Verify the domain (DNS records) and gate on `verification.verified` first. |
| Shipping the API key in client/mobile/public code | It grants full workspace send access — keep it server-side only. |
| Retrying on `429`/`400` immediately | Honor `Retry-After` for `429`; fix and don't retry `400`/`401`/`404`. |
| Re-engaging an inactive user via `/send` | Re-request consent to reset `inactive` → `pending` (the Engagement Check). |
| Putting clickable links in transactional flows | Transactional bodies are link-free; deliver the code/value and handle clicks in your app. |
| Adding your own unsubscribe footer | GoodSender adds compliance footers automatically. |

For exact request/response fields, enums, and all endpoints, see [api-reference.md](references/api-reference.md).

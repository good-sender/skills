---
name: goodsender-api-integration
description: Use when integrating the GoodSender email API into an app or service — obtaining and configuring an API key, verifying a sender domain, requesting recipient consent, and sending general or transactional email over HTTP. Covers the consent model, auth, error/quota handling, and the correct send flow.
license: Apache-2.0
---

# Integrating the GoodSender Email API

## Overview

GoodSender is a free, **consent-based** email service. Your app sends email over a small HTTP API. The defining rule that shapes every integration:

> General email is delivered **only to recipients who have granted consent** for your sending domain. You request consent once per recipient; GoodSender emails them an approve/reject prompt; only after they approve will `/v1/emails/send` deliver to them. Recipients without granted consent are silently counted as `declined`, not delivered.

The exception is **transactional templates** (OTP, order confirmation, etc.) via `/v1/emails/template`, which don't require prior consent.

Design your integration around these two paths. Full endpoint/field details live in [api-reference.md](references/api-reference.md); this file is the workflow.

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
| Newsletters, announcements, notifications, anything marketing-ish | `POST /v1/emails/send` | Yes — recipient must have `granted` |
| OTP / 2FA codes, order confirmations, security alerts, device-login alerts | `POST /v1/emails/template` | No — auto-registers recipient as `pending`; only `denied` recipients are skipped |

Do **not** route bulk/marketing mail through the transactional template endpoint to dodge consent — those are limited to the four built-in transactional templates and each carries a manage-preferences footer.

## Step 4 — The consent-based send flow

For general email, your app's lifecycle per recipient is:

1. **Request consent** (`POST /v1/emails/consent`) when a user opts in (signup, "subscribe", etc.). GoodSender emails them; their status goes `pending → requested`, then `granted` or `denied` once they respond.
2. **Track status.** Either poll `GET /v1/emails` incrementally (filter `consentStatus=granted` and/or use `consentStatusUpdatedAfter` to sync only changes) and store consent state in your own DB, or check a single address with `GET /v1/emails/{email}`.
3. **Send** (`POST /v1/emails/send`) whenever you like. Don't pre-filter by your cached state alone — GoodSender enforces consent at send time and returns `{ sent, declined }`. Treat `declined` as "not yet consented or inactive," not as an error.

A `200` response does **not** mean everyone received the email — always inspect `sent` vs `declined`.

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

// Transactional path — no consent needed, single recipient.
const { status } = await gs("/v1/emails/template", {
  method: "POST",
  body: JSON.stringify({
    from: { email: "auth@yourdomain.com", name: "Your App" },
    to: { email: "user@example.com" },
    subject: "Your verification code",
    template: { template_id: "otp_code",
      variables: { app_name: "Your App", otp_code: "482916", expiry_minutes: "10" } },
  }),
}); // status: "sent" | "declined"
```

Quick `curl` equivalents for testing each endpoint are in [api-reference.md](references/api-reference.md).

## Operational rules

- **Quotas (429).** There are daily and monthly send quotas. On `429`, read the `Retry-After` header and the body (`kind`, `limit`, `used`, `resetAt`) and back off until reset — never tight-loop retries.
- **Retries.** `500`/`502` are safe to retry with backoff (consent creation is idempotent). `400`/`401`/`404` are not retryable — fix the request.
- **Inactivity.** A `granted` recipient with no opens/clicks for 120+ days becomes `inactive` and is blocked from `/v1/emails/send`. To re-engage, call `/v1/emails/consent` again — it resets them to `pending` and sends a fresh consent email.
- **Batching.** Up to 1000 recipients per email and multiple emails per `send` request. Large attachments/recipient counts can return `413`.
- **No unsubscribe footers needed.** GoodSender appends required compliance footers automatically; don't add your own.
- **Scheduling.** `send_time` (unix seconds, ≤72h ahead) defers delivery; `0`/omitted sends immediately.

## Common mistakes

| Mistake | Reality |
|---------|---------|
| Treating a `200` as "everyone got it" | Check `sent` vs `declined`; `declined` = no granted consent (or inactive). |
| Sending before requesting consent | General email to non-consented recipients is silently declined. Request consent first. |
| Using `/v1/emails/template` for marketing | Only 4 built-in transactional templates, single recipient, manage-prefs footer. Use `/v1/emails/send` for marketing. |
| Sending from an unverified domain | Verify the domain (DNS records) and gate on `verification.verified` first. |
| Shipping the API key in client/mobile/public code | It grants full workspace send access — keep it server-side only. |
| Retrying on `429`/`400` immediately | Honor `Retry-After` for `429`; fix and don't retry `400`/`401`/`404`. |
| Re-subscribing an inactive user via `/send` | Re-request consent to reset `inactive` → `pending`. |
| Adding your own unsubscribe footer | GoodSender adds compliance footers automatically. |

For exact request/response fields, enums, and all endpoints, see [api-reference.md](references/api-reference.md).

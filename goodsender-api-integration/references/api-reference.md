# GoodSender API reference

Full endpoint and field reference for the GoodSender HTTP API. Read [SKILL.md](../SKILL.md) first for the integration workflow; this file is the lookup table.

- **Base URL:** `https://api.goodsender.com` (dev/staging: `https://api.dev.goodsender.com`)
- **Auth:** every request requires `Authorization: Bearer <YOUR_API_KEY>`
- **Content type:** `application/json` for all request bodies
- **API version:** paths are prefixed with `/v1`

## Endpoints

| Method & path | Purpose |
|---------------|---------|
| `POST /v1/emails/consent` | Request recipients' consent for a sender domain |
| `POST /v1/emails/send` | Send one or more custom emails (delivered only to consented recipients) |
| `POST /v1/emails/template` | Send a transactional templated email (bypasses the Permission Loop) |
| `GET /v1/emails/{email}` | Get a recipient's consent status |
| `GET /v1/emails` | List recipient consent statuses (paginated, filterable) |
| `GET /v1/domains` | List sender domains and their DNS verification state |

---

## POST /v1/emails/consent

Sends a consent message so recipients can approve/reject future email from your domain. Auto-creates unknown recipients with `pending` consent.

Request body:

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `domain` | string | yes | Sender domain the consent is for (must be a verified workspace domain) |
| `emails` | array | yes | 1–1000 entries. Each is either a bare email string or `{ "email": string, "name"?: string }` (mixing forms allowed) |
| `redirect_url` | string | no | URL the recipient is sent to after responding |

`name` semantics: a non-empty name sets/replaces the stored display name (last write wins per workspace+domain+email); `null`/empty/omitted leaves it unchanged.

Response `200`: `{ "emails": [EmailAccount, ...] }` (see EmailAccount below).

Re-requesting consent for a recipient who is `granted` but `inactive` resets them to `pending` and dispatches a fresh consent email — the supported way to re-engage someone blocked by inactivity.

---

## POST /v1/emails/send

Sends custom email. **Only recipients with `granted` consent (via the Permission Loop) and active engagement receive the email**; others are counted as `declined`, not delivered. Inactive recipients (120+ days no opens/clicks — the Engagement Check) are declined even when `granted`.

Request body: `{ "emails": [ SendEmail, ... ] }` (non-empty).

`SendEmail` object:

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `from` | Address | yes | `{ "email": string, "name"?: string }` |
| `to` | Address[] | yes | ≥1 recipient; **max 1000 recipients per email** |
| `subject` | string | yes | |
| `text_content` | string | one of* | Plain text |
| `html_content` | string | one of* | HTML |
| `markdown_content` | string | one of* | Markdown; when set, `text_content`/`html_content` are ignored (markdown is used as text and rendered to HTML) |
| `template_id` | string | one of* | Use a server template instead of inline content |
| `template_data` | object | no | Variables for `template_id` |
| `attachments` | Attachment[] | no | See Attachment below |
| `reply_to` | Address | no | |
| `headers` | object<string,string> | no | Custom email headers |
| `send_time` | int64 | no | Unix seconds to send at; must be ≤72h in the future; `0`/omitted = immediate |
| `tracking` | TrackingSettings | no | See below |
| `tag` | string | no | Custom tracking tag, ≤100 chars |
| `webhook_data` | object<string,string> | no | Custom data echoed in webhook events; ≤10 keys, key ≤50 chars, value ≤100 chars |

*At least one of `text_content`, `html_content`, `markdown_content`, or `template_id` is required.

Response `200`: `{ "sent": int, "declined": int }`.

---

## POST /v1/emails/template

Sends a single transactional email from a predefined template. **This path bypasses the Permission Loop entirely**: no consent and no prior registration are required, it sends instantly to any address (including one GoodSender has never seen, so no `404` for unknown recipients), and a Permission Loop reject (`denied`) does **not** block it — a reject only stops custom (`/v1/emails/send`) email. Transactional sends never change a recipient's consent state. Bodies are link-free (anti-phishing). URL-type variables must point to the sender's domain.

> **Source note:** Confirmed against the API server and its tests (`goodsender-web`): denied and unknown recipients still receive transactional templates, and the endpoint always returns `{"status":"sent"}` — it never returns `declined`. The `goodsender-mcp-go` OpenAPI copy is stale on this point (tracked in `inboxbit/goodsender-mcp-go#1`).

Request body:

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `from` | Address | yes | |
| `to` | Address | yes | Single recipient (object, not array) |
| `subject` | string | yes | |
| `template` | object | yes | `{ "template_id": string, "variables"?: object<string,string> }` |

Built-in transactional template IDs and their variables (all variable values are strings; the catalogue grows over time):

| `template_id` | Purpose | Variables |
|---------------|---------|-----------|
| `otp_code` | One-time passcode for 2FA / passwordless login | `app_name`, `otp_code`, `expiry_minutes` |
| `mfa_enrollment` | Confirm a user enabling multi-factor auth | `app_name`, `mfa_method`, `enrolled_at` |
| `new_device_login` | Alert on access from a new device | `app_name`, `login_time`, `additional_info` |
| `order_completed` | Confirm a completed checkout | `app_name`, `order_id`, `order_total`, `completed_at` |
| `order_receipt` | Purchase receipt with line items and payment details | `app_name`, `description`, `receipt_number`, `purchase_date`, `payment_method`, `total` |
| `email_changed` | Alert that the account email address changed (with compromise warning; sent to the last known address) | `app_name`, `new_email`, `changed_at`, `additional_info` |
| `password_changed` | Confirm a password change (with compromise warning) | `app_name`, `changed_at`, `additional_info` |

Omitted variables render as empty strings. Response `200`: `{ "status": "sent" }` (the endpoint does not return `declined`).

---

## GET /v1/emails/{email}

Returns the consent status for one address. Query param `domain` (optional) filters to one sender domain; omit for all domains.

Response `200`: array of `EmailAccount`. `404` if the address is unknown.

---

## GET /v1/emails

Paginated, filterable list of recipient consent statuses for the workspace. Filters combine with AND.

Query params (all optional): `domain`, `limit` (1–100, default 50), `cursor`, `consentStatus` (single or comma-separated: `pending,requested,granted,denied`), `engagementStatus` (`new|hot|warm|cooling|dormant|inactive`), `consentStatusUpdatedAfter` (unix seconds), `updatedAfter` (unix seconds).

Response `200`: `{ "emails": [EmailAccount, ...], "nextCursor"?: string }`. To sync incrementally, track the max `consentStatusUpdatedAt` across rows and pass it as the next `consentStatusUpdatedAfter`.

---

## GET /v1/domains

Paginated list of sender domains with verification state. Query params: `limit` (1–100, default 50), `cursor`.

Response `200`: `{ "domains": [Domain, ...], "nextCursor"?: string }`.

`Domain`: `{ domain, tracking, return_path, require_tls, verification }` where `verification` = `{ verified, tracking_verified, return_path_verified, dkim1_verified, dkim2_verified }`. `verified` is the overall flag; the per-record booleans show which DNS records still need attention.

---

## Shared objects

**Address:** `{ "email": string (required), "name"?: string }`

**Attachment:** `{ "content_type": string (required), "content"?: base64 string, "file_name"?: string, "inline_id"?: string }`. Either `file_name` or `inline_id` is required; `content` must be base64-encoded.

**TrackingSettings:** `{ "opens"?: bool, "clicks"?: bool, "unsubscribes"?: bool, "unsubscribe_group_id"?: int64|null }`. `unsubscribe_group_id` is ignored when `unsubscribes` is false.

**EmailAccount:**

| Field | Type | Notes |
|-------|------|-------|
| `email` | string | |
| `name` | string \| null | |
| `domain` | string | |
| `consentStatus` | enum | `pending` (awaiting send) → `requested` (consent email sent) → `granted` / `denied` |
| `engagementStatus` | enum | `new`, `hot`, `warm`, `cooling`, `dormant`, `inactive` (120+ days idle → blocked from sending) |
| `consentStatusUpdatedAt` | int64 | Unix seconds of last consent change |
| `updatedAt` | int64 | Unix seconds of last row update |

---

## Status codes & errors

| Code | Meaning | Action |
|------|---------|--------|
| `200` | Success | Inspect `sent`/`declined` or `status` — a `200` does **not** mean every recipient was delivered |
| `400` | Validation error | Fix the request; body `{ error }` or `{ code, message }` |
| `401` | Invalid/missing API key | Check the `Authorization` header |
| `404` | Not found (unknown template or address) | |
| `413` | Payload too large | Reduce attachments/recipients/batch size |
| `429` | Quota exceeded (daily or monthly) | Read `Retry-After` header and the body `{ code: "quota_exceeded", kind: "daily"\|"monthly", limit, used, resetAt }`; back off until `resetAt` |
| `500` | Internal error | Safe to retry (consent creation is idempotent) |
| `502` | Upstream email service unavailable | Retry with backoff |

Error bodies come in two shapes: the email-send endpoints return `{ "error": string }`; consent/list/domains return `{ "code": string, "message": string }`. Handle both.

# Distribution through GoodSender

Read only when preparing destination copy or publishing. These notes describe the tools verified for this package; live schemas, limits, and responses govern the current connection.

## Inspect before changing

`get_post_distribution(PostID)` reports the public `HomeURL`, post status, external destinations, and newsletter. Each external destination includes availability, connection/account, selection, saved announcement `Copy`, effective `Text`, delivery state, errors, and (for announcements) `Budget`.

Offer only available connected accounts for immediate distribution. Explain how a user can connect a missing destination without claiming the current connection can deliver there. No post ID or missing tool means distribution cannot yet be inspected; never invent the connected account list.

`set_post_distribution` is a partial update: omitted fields remain unchanged. Re-read before editing an existing post. Its returned changes describe the pending or applied plan; a confirmation-required response is not a successful save. Use the host's authorized confirmation flow and verify the final response.

## Announcements

Each of `X`, `LinkedIn`, `Bluesky`, and `Mastodon` accepts `Selected` and `Copy`; clearing copy is a separate operation. `Copy` excludes the post link because the service appends it.

Adapt the framing to the intended readers rather than adding generic platform mannerisms. For example, a professional audience may need the operational implication and a concrete example; a short announcement may need only the specific problem and payoff. Avoid invented anecdotes, unrelated hashtags, repetitive hooks, or exaggerated promises.

Check `Budget.Used`, `Budget.Max`, and `Budget.Over`, including the appended link's contribution. A rejected over-limit save needs a shorter version, not a claim that the rejected text was stored. Do not rely on service truncation. Verify the final saved copy after changes.

## Republication

`Devto` and `Hashnode` select full-article republication. Keep the same article, title, and canonical original. This workflow does not require alternate article versions. A later publish may update existing republished copies, so an edit to an already-published post may affect them.

## Newsletter

`Newsletter` accepts `Selected`, `Subject`, and `Summary`. Use explicit dedicated subject and copy rather than silently falling back to the post title and summary. Verified limits are a one-line subject up to 200 characters and a summary up to 5,000 characters; check current schemas if they differ.

The summary renders as Markdown, followed by the service's fixed “Read the full post” button linking to the article. It is not the full post body. Keep the post link out of the summary unless the user has a specific reason to repeat it. Other relevant links may support the goal, but do not represent them as customization of the built-in button.

Cover inheritance into newsletter email is not established by the presence of `CoverImageURL` on the post. Check current rendering behavior. If unsupported, explain the gap rather than claiming the cover appears automatically. An explicitly inserted uploaded Markdown image may be used only when supported and verified in the rendered email; avoid adding it if automatic cover rendering would duplicate it.

Inspect recipient count, sender/public-address blockers, prior send time, and errors before sending. `send_post_test` can test a draft in one user-provided inbox using the intended subject and summary. This sends a real email and uses quota. If no public post address exists, the test CTA may fall back to the blog landing page; tell the user that a draft test does not prove the final CTA destination.

## Delivery semantics

- `publish_post` publishes the page and acts on its saved distribution selection. Republish destinations may update; announcements and newsletter run once per post through normal publish.
- `broadcast_post` is an explicitly requested newsletter send for a published post, at most once and unavailable after publication already mailed it. It is not the next mandatory step after every publish.
- `reannounce_post` deliberately posts an announcement again. It is a separate action, not a way to check delivery.
- Remote failures need not fail the page publish. Report each destination's actual result.
- A timeout or ambiguous result is a reason to inspect saved state before another mutation; do not blindly repeat creation or delivery.
- Unpublishing cannot recall delivered email or automatically remove external posts.

Respect existing authorization. Prepare drafts and previews within the request; publish, email, or announce only to the destinations the user authorized. A tool confirmation token alone is not permission for a new action.

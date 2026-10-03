# Existing posts and staged revisions

Read before changing an existing post. Call `get_post` to establish its status, current content, and metadata. Use the current tool schemas for field semantics.

## Choose the write target

- **Existing draft:** apply the requested changes to the draft, verify the saved result, and create a fresh preview.
- **Published post, live edit authorized:** apply the requested change directly. A request such as "fix this typo on the live post" already authorizes that edit; do not require another editorial approval. Preserve unrelated content and distribution. Editing the page does not resend announcements or email.
- **Published post, revision for review:** stage the proposed changes locally or in the conversation. Do not call `edit_post` on the original: edits reach its live page even though the tool does not transition a draft to published status. If a hosted draft preview is requested, use `create_post` for a separate draft with a distinct slug, without copying the original's publication date or distribution selections. Identify it as a review copy of the original.

Keep the original post ID, original content being changed, and proposed revision together. For local staging, put the proposed body and metadata in the post's working folder as `revision.md`; do not describe it as saved to GoodSender. A preview of the unchanged original is not a preview of the proposal.

When the user authorizes applying a staged revision, re-read the original and apply the reviewed changes to that current version. Preserve unrelated intervening edits; if the same passage changed incompatibly, show the conflict before overwriting it. Check changed claims and dependent fields before the live write. Do not call `publish_post` just to apply a text edit: that call also acts on distribution. Republish updates or renewed announcements require the corresponding authorization.

## Preserve complete values

`edit_post` replaces `Markdown`, `Tags`, and `Categories` wholesale when supplied with non-empty values. Read the current post first and send the complete resulting field, not a changed paragraph or one additional tag. Send only fields within the requested edit.

Empty strings and empty taxonomy arrays normally mean unchanged, not cleared. `CoverImageURL` is the exception: omitting it preserves the cover, while an explicit empty string clears it. If a requested removal is unsupported by the current tool, report the limitation instead of claiming the value was cleared.

Verify the resulting fields through the successful tool result or a readback. Keep staged distribution copy with an unapproved live revision; do not overwrite the original's saved distribution plan during review.

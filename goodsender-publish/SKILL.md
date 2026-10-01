---
name: goodsender-publish
description: Create or revise a GoodSender blog post and prepare its cover, inline visuals, social announcements, and newsletter around the user's publishing goal. Use for drafting, preparing distribution, reviewing, or publishing through connected GoodSender tools. Honor requests for a simple sample or a narrow edit without expanding them into a campaign.
license: Apache-2.0
metadata:
  version: "0.1.0"
---

# GoodSender publishing

Produce a post and its selected distribution that lead the intended reader toward the user's stated outcome. GoodSender is the publishing destination; the article need not be about GoodSender. Use the user's publication, sources, language, and voice.

## Start with intent and the right publication

Use available GoodSender MCP tools, allowing for client-specific prefixes. Read their current descriptions and schemas; this skill does not override tool or host authorization requirements. Do not require a local repository, Python pipeline, particular model, or paid image generator.

Call `get_blog` to verify the workspace and domain, and `list_posts` before drafting to learn the byline, author URL, existing tags/categories, voice, and covered topics. If there are several configured connections, use the one matching the requested publication. If none matches, explain the connection needed and continue preparing content locally where useful. Do not write to another publication or look for unrelated credentials.

For a substantive new post, establish the reader's intended action or takeaway before writing. If missing, ask one concise question covering the goal and audience, for example: “Who is this for, and what should they do or understand afterward: register, follow a link, learn something, or understand a release?” For an action goal, obtain the real destination URL. Do not invent one. Reuse answers from the conversation rather than asking again.

Keep a compact working brief: publication, audience, goal, CTA and URL if applicable, evidence, voice/language, assets, destinations, and draft/review/publish intent. A sample draft needs only sample content and a preview, unless the user asks for more. A narrow edit should preserve unrelated content and distribution.

## Write toward the goal

Ground product details, statistics, quotes, personal experience, and named examples in supplied evidence or checked sources. Cite external claims near the relevant text. Distinguish plans from released behavior. Do not copy private source material into a public post merely because you can read it.

Use existing editorial instructions when available. If no language or locale is established, default to American English. Preserve the author's perspective without inventing experiences or credentials. A compelling title makes a specific promise the article fulfills; avoid fabricated urgency or unsupported results.

Prepare these distinct artifacts:

| Artifact | Job |
| --- | --- |
| Title | Give the intended reader a concrete reason to open the article. |
| Summary | Orient an arriving reader; it appears under the title, on cards, and in feeds. |
| Description | Explain relevance to someone seeing a search result or social card. |
| Body | Deliver the promised explanation or evidence, with a natural next step supporting the goal. |
| Tags and categories | Reuse the blog's established taxonomy where it fits. |
| Author and author URL | Reuse the latest post's byline unless the user identifies a different author; ask if genuinely unknown. |

Do not reuse one sentence for Title, Summary, and Description. Do not force a promotional CTA into an informational article. For a registration goal, connect the article's useful explanation to the actual registration page; for a changelog, explain what changed and who should act.

Use Markdown tables for comparisons, linked citations or footnotes for evidence, and code blocks for code. GoodSender renders Markdown with raw HTML disabled: HTML, inline SVG, and Mermaid are not substitutes for supported visuals. Keep the platform Title separate from the body so the H1 is not rendered twice.

## Prepare the images

For a full article, ask once whether the user has a cover or inline images, wants them generated, or prefers no images. Honor supplied preferences and explicit image-generation requests without asking again. This decision can be collected with the initial brief while you research or outline.

Use supplied assets when appropriate. Otherwise, use the host's image-generation capability if available and wanted. Design the cover around the article's central idea and audience, with a clear focal point that survives small cards and cropping. Inline images should explain something the prose or table does not. Do not invent screenshots, evidence, or customer results. If generation is unavailable, provide a usable visual brief and report the missing asset; do not claim an image exists.

Upload final images with `upload_post_image` and use its returned URLs. Set the cover using `CoverImageURL`; the first body image does not become the cover. Place inline images in Markdown with useful alt text. Use cover alt text and dimensions when the current tools expose them; do not invent unsupported fields. A cover need not also appear inside the article.

## Save the draft and prepare distribution

Create the post with `create_post`, or read and update an existing post with `get_post` and `edit_post`. Creation is draft-only. Save complete metadata and visuals before final review. Include provenance when supported and known, describing the actual authoring agent and sources; do not guess a model, repository, commit, or completed publication.

For a full publishing request, continue beyond draft creation into the requested preparation. For an explicitly simple sample or draft-only request without distribution preparation, return its preview without a campaign questionnaire.

Read `get_post_distribution` after the draft exists. Show the connected account names and available destinations. If distribution preferences are missing, ask whether to use all connected social/republish destinations, selected destinations, or the blog only, and separately make newsletter inclusion clear. Ask whether these should go out on publication or only be prepared for review. A connected account is an option, not consent to use it.

Use [distribution.md](references/distribution.md) when preparing or publishing to destinations. Its core rules are:

- **Announce:** write separate X, LinkedIn, Bluesky, and Mastodon copy for the selected destinations, adapted to their audience and the post's goal. Do not paste the same blurb everywhere. The service appends the article URL; leave it out of saved announcement copy. Use the current tool's budget information rather than assumed character limits.
- **Republish:** dev.to and Hashnode receive the same article with canonical attribution. Do not write or promise separate destination-specific articles.
- **Newsletter:** write a dedicated inbox subject and short Markdown summary giving subscribers a reason to read. The service adds a “Read the full post” button. Do not promise a configurable button label/target or automatic cover inclusion unless verified in the current capability and rendered output.

Save approved destination choices and copy with `set_post_distribution`. It prepares future delivery without sending. Preserve settings outside the requested change; explicitly deselect destinations when needed to match an authorized blog-only publication. Re-read distribution to verify selected accounts, saved copy, budgets, newsletter recipient count, and blockers. Surface missing capabilities instead of silently substituting fallback blurbs.

## Final review and publication

For draft delivery or review, generate `create_post_preview` after the latest edits. Provide the link alongside the cover, announcement copy, newsletter subject/body, selected account names, and intended CTA as relevant. Skip the preview detour when the user explicitly requests immediate publication without review. The blog preview alone is not a newsletter preview. If the user wants an email test, obtain their own inbox and use `send_post_test` with the exact subject and summary; do not guess an address or send tests to the subscriber list.

For draft-only work, stop with the saved draft and preview. For ordinary publication, let the user review the completed package and approve its actual destinations. If they explicitly asked to skip review and publish now, honor that instruction within the publication and destination scope they authorized; do not turn skipping preview into permission to add channels or email subscribers. Follow any host/tool confirmation requirement that still applies.

Immediately before publication, verify the workspace, current post, and `get_post_distribution` again. Summarize the concrete delivery plan when asking for any missing authorization. `publish_post` can publish the page AND distribute to selected destinations, including newsletter email. Never assume it changes only the web page.

After a publish, check the post and distribution results. Separate published, delivered, pending, blocked, and failed outcomes. Use bounded follow-up reads for pending deliveries, then report what remains pending. A successful page publish does not prove successful distribution. Do not call `broadcast_post` after the newsletter has already been sent, or use `reannounce_post` as an automatic retry.

End with the draft preview or published URL, the achieved status, and any material missing assets or delivery failures. Never claim that saving a draft published it or that an email can be recalled.

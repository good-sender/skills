# Images

Read at stage 9 for a full draft or quick sample, and again when the author answers the image question. Plan images around the current text and post type. Placement should preserve unrelated prose; any needed caption or factual revision must be checked before saving.

## Decide once, after the draft

Never ask about images in intake. The author decides better from the finished post.

An answer already given in the request settles the stage: apply it at stage 9 without asking. A durable preference in `visual.md` or `gs/feedback.md` counts as an answer too; say in one line that it was applied, so the author can override it. When the author wants no images, finish this stage without briefs, generation, uploads, substitute diagrams, or missing-asset warnings. For a narrow edit, preserve existing images unless the user asked to change them.

Otherwise draft an image plan at stage 9 but generate and upload nothing: the cover and only the inline slots that pass the usefulness bar, each with its anchor and a one-line description. Save the draft without images. Whenever the saved draft has no images, the stage 12 review package shows the plan and asks once, as a question with answer options, through the host's structured question tool (for example `AskUserQuestion`) when one exists and as a numbered list otherwise:

**Question:** The draft is saved without images. What should happen with them?

1. **Generate:** all planned images, or the listed ones.
2. **Upload my own:** attach files, give local paths or URLs, and say which slot each fills, or let the assistant place them.
3. **Leave without images.**

Ask it together with the integrations question from [distribution.md](distribution.md) when that one applies, each as its own question in the same message. Mixed answers are fine, such as an own cover with generated inline images. Do not ask when the user said not to ask questions or authorized publication without review; finish without images and say so in one line. An unanswered question leaves the draft without images; never hold the draft or an authorized publication on it. A durable answer ("always generate a cover", "I will supply my own") is feedback: record it per [improve-yourself.md](improve-yourself.md), keeping `visual.md` consistent if it exists.

## Style

Take the style from the first of these that exists, and say which you used:

1. `visual.md` in the workspace folder
2. The blog's previous covers (look at them if you can view images)
3. A site the user named
4. A plain, consistent default

## Plan

Plan only the requested assets: a cover, inline images, or both. Zero inline images is valid. For each image:

| Field | Content |
| --- | --- |
| Anchor | An exact heading or a unique nearby passage, copied from the post. The cover has no anchor; a heading-free essay need not gain headings for images. |
| Alt text | What the image shows, for a reader who cannot see it |
| Brief | Subject, composition, palette, any short labels, what to avoid |
| Aspect ratio | Wide for a cover; whatever suits the content inline |

## The usefulness bar

For factual posts, an inline image should explain a process, contrast, or structure beyond the prose or a table. For creative work, a requested illustration may develop the scene, atmosphere, or narrative. Use the post's purpose to judge usefulness; do not add decorative assets the user did not request.

The cover is the one exception. It may be conceptual, built around the article's central idea and audience, with a clear focal point that survives small cards and cropping.

## Never

- Fabricated product UI, screenshots, dashboards, or logos
- Charts of data that does not exist
- An image presented as evidence of something that happened
- Long or critical text inside a generated image; generators render text imperfectly

Use supplied assets when they fit. A real screenshot comes from the author, not from a generator.

## Supplied media

- Accept files attached in the conversation, local paths, or URLs the author gives. A URL is a source to fetch bytes from, never an embedded link; if the bytes cannot be read, report that asset missing.
- Look at each one before using it: it fits its slot, is legible at its displayed size, and shows no private data or secrets the author may not intend to publish. Flag a doubtful one instead of silently dropping or using it.
- Write alt text from what the image actually shows. A caption stating what it depicts rests on the author's word; record it in the ledger.
- A planned slot the author's media leaves empty stays empty unless they also asked to generate it. Never fill a screenshot slot with a generated image.

## After the answer

1. Produce or accept the chosen assets: supplied media per the section above, generated images per Style, Plan, and Validation.
2. Place, upload, and set the cover as below.
3. Update the saved draft with `edit_post`, or the staged revision for a live post, following [editing.md](editing.md); preserve everything else.
4. Rerun the body lint and check new captions and alt text. If a cover changes newsletter rendering, re-verify per [distribution.md](distribution.md).
5. Re-mint the preview and reply briefly: preview link, images added, any missing assets and their briefs.

## Validation

Look at every generated image before using it.

- [ ] The subject matches the brief and the alt text
- [ ] No garbled or misspelled focal text (small imperfect labels are acceptable)
- [ ] No fabricated UI, screenshots, or logos
- [ ] Consistent with the blog's style
- [ ] Sane composition; nothing important lost at card size
- [ ] Useful to the post's purpose, including narrative or atmosphere for creative work

On a failure, rewrite the brief to fix the named problems and regenerate. At most two retries per image; then drop it and say so. If you cannot view images on this host, tell the user the images are unreviewed.

## Placement

Insert the Markdown image line at its planned anchor. If that text is missing or ambiguous, choose another clear location rather than silently inserting elsewhere. Preserve unrelated prose and recheck any added factual caption or alt text.

## Upload

- Upload real bytes with `upload_post_image`. Only the URLs it returns are valid; never an external URL, a guessed path, or a local file path.
- The cover is set through `CoverImageURL`. An image in the body never becomes the cover, and a cover need not appear in the body.
- Write real alt text for body images. Use cover alt text and dimensions only when the current tool exposes them.

## A requested image cannot be produced

If no supplied asset or available tool can produce a requested image, write a visual brief and report that asset missing. For an explanatory diagram, use a Markdown table or structured list where it serves the same purpose; a missing creative illustration does not call for a table. Never claim an image exists, and never substitute HTML, inline SVG, or mermaid.

# Images

Read at stage 9 when images are wanted. Plan them around the current text and post type. Placement should preserve unrelated prose; any needed caption or factual revision must be checked before saving.

## Decide once

For a full article, ask once (in the intake message) whether the user has a cover or inline images, wants them generated, or wants none. Honor a stated preference or an explicit request without asking again.

When the user wants no images, finish this stage without briefs, generation, uploads, substitute diagrams, or missing-asset warnings. For a narrow edit, preserve existing images unless the user asked to change them.

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

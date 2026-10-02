# Images

Read at stage 9. Images are planned after the text is final, and placing them never changes a word of it.

## Decide once

For a full article, ask once (in the intake message) whether the user has a cover or inline images, wants them generated, or wants none. Honor a stated preference or an explicit request without asking again.

## Style

Take the style from the first of these that exists, and say which you used:

1. `visual.md` in the workspace folder
2. The blog's previous covers (look at them if you can view images)
3. A site the user named
4. A plain, consistent default

## Plan

A cover plus zero or more inline images. Zero inline images is a valid plan. For each image:

| Field | Content |
| --- | --- |
| Anchor | The exact heading it sits under, copied from the post. The cover has no anchor. |
| Alt text | What the image shows, for a reader who cannot see it |
| Brief | Subject, composition, palette, any short labels, what to avoid |
| Aspect ratio | Wide for a cover; whatever suits the content inline |

## The usefulness bar

An inline image must explain something the prose or a table does not: a process, a contrast, a structure. Favor compositions that carry meaning, such as before and after, a left-to-right flow, or a layered stack. If an image would only decorate, do not make it.

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
- [ ] Useful, not merely decorative (the cover is exempt)

On a failure, rewrite the brief to fix the named problems and regenerate. At most two retries per image; then drop it and say so. If you cannot view images on this host, tell the user the images are unreviewed.

## Placement

Insert the Markdown image line directly beneath its anchor heading. An anchor that matches no heading, or more than one, is skipped. Before and after placement, the prose must be identical.

## Upload

- Upload real bytes with `upload_post_image`. Only the URLs it returns are valid; never an external URL, a guessed path, or a local file path.
- The cover is set through `CoverImageURL`. An image in the body never becomes the cover, and a cover need not appear in the body.
- Write real alt text for body images. Use cover alt text and dimensions only when the current tool exposes them.

## No generator, or no images wanted

Write a visual brief for each planned image, report the asset as missing in the review package, and use a Markdown table or structured list where a diagram was planned. Never claim an image exists, and never substitute HTML, inline SVG, or mermaid.

# The blog design

Read when the author answers the design question with "generate", or asks for a new blog design outright. The design is the blog's look: five Liquid templates that GoodSender renders for every page. It belongs to the publication, not to one post, so this work runs beside the post and never holds it.

## When the question is asked

`get_blog` reports `Design.IsDefault`. True means the blog still renders the stock design every workspace starts from; false means the author already has their own, and it is never proposed for replacement unasked. If the response has no `Design` field (an older server), fall back to `blog_design_list`: exactly one design, flagged `IsDefault` or titled `Default`, counts as the stock design, and say in one line that this was inferred. Never invent the field.

When the stock design is live, the stage 12 review package asks once, after the draft is saved, as a question with answer options through the host's structured question tool (for example `AskUserQuestion`) when one exists and as a numbered list otherwise:

**Question:** Your blog still uses the standard GoodSender design. Should I create one of its own?

1. **Generate a design:** from the blog's title, description, posts, covers, and any direction you add here (mood, colors, a site you like, a logo file).
2. **Keep the standard design** and do not ask again.
3. **Not now.**

Ask it in the same message as the image and integrations questions when those apply, each as its own question. An answer already given in the request settles it: apply that answer at this stage without asking, as images.md does. Skip it for a narrow edit, a feedback-only request, when the author asked for no questions or authorized publication without review, or when `gs/feedback.md` or `blog.md` already answers it. "Keep the standard design" is durable feedback, however it was given: record it per [improve-yourself.md](improve-yourself.md) (kind: preference, scope: this publication / blog design) so the question is not repeated. "Not now" leaves the question for a later invocation; note it with the date under `## Design` in `blog.md` so the next run knows it was asked and declined for now, and do not ask twice in one session. An unanswered question never holds the draft, the preview, or an authorized publication.

Never ask about the design in intake, and never create, edit, or activate a design before the author answers.

## Inputs

Take the direction from the first of these that exists, and say which you used:

1. What the author wrote with their answer, and `visual.md`
2. The blog's profile: title, description, language, audience, voice, and the covers of recent posts (look at them if you can view images)
3. A site the author named, read with an available read-only web tool
4. A plain, legible default: one accent color, readable serif or sans body type, generous whitespace

Rule 1 applies: the templates carry the blog's real title and description from `get_blog`, no invented tagline, slogan, author bio, address, social link, or sample text that would publish as fact. Decorative copy that is clearly structural ("Latest posts", "Subscribe") is fine.

## Generate

1. Read `blog_design_template_format` first. It is the contract: the five templates, the data each page receives, and the blocks the server requires. Do not write a template from memory of an earlier run.
2. Write all five templates (`SharedHeader`, `Landing`, `Post`, `Archive`, `Tag`) against that contract. `SharedHeader` is the `shared_head` partial: every page renders it inside `<head>`, so the fonts and the CSS live there and the four pages stay consistent. Every page renders the attribution partial, is responsive, and the post page outputs the post body exactly as the format document says. At least one page carries the subscribe block with its email input and submit button. Use only the page data the format document lists; do not invent URLs or fields it does not name.
3. Call `blog_design_create` with a `Title` that names the design (for example "`<Blog title>` design"), `BlogTitle` and `BlogDescription` copied from `get_blog`, the templates, and `Images` with `null` for every image you do not have. Tell the author every notice the result returns, in the same message; a notice does not undo the design. A rejected create means a template broke the contract: fix the named problem and create again, at most twice, then report the brief instead of a design.
4. Show the author the returned `CheckpointPreviewURL`, plus the same URL with `?page=post`, `?page=archive`, and `?page=tag`. The preview is the only way they see the design; never claim to have looked at it unless you rendered it on this host. If you can view pages, check each one before handing over: legible at phone width, nothing overlapping, the post body visible.
5. Refine on the author's remarks with `blog_design_edit`: read the latest checkpoint first (`blog_design_get_latest_checkpoint`), pass its `EditToken`, change only the strings they asked about, and name the checkpoint after the change. Repeat the notices rule. Use `blog_design_checkpoint_restore` only when the author asks to go back; it deletes the newer checkpoints and needs their confirmation.

## Logo and favicons

A logo and favicons come from the author's own files, never from a generator: a fabricated logo is a fabricated brand. When they supply one, call `blog_design_image_upload_url`, `PUT` the raw bytes to the returned URL with the right `Content-Type`, and pass the stored URL the response returns to `blog_design_edit` (`LogoURL`, `Favicon32URL`, `Favicon180URL`). If this host cannot make that HTTP request, say so and leave the images unset; the design still works without them.

## Save and activate

Saving and activating are two separate, live actions.

- `blog_design_save` keeps the newest checkpoint as the only version of the design. Call it once the author is done refining, or right away when they gave no remarks; it needs no new notices, the earlier ones were already reported.
- `blog_design_activate` makes the design the public site at once, for every reader. This is rule 2: ask the author before calling it, naming the design and the blog it replaces, and honor an authorization already given. The tool itself asks for confirmation on the default MCP setup; a confirmation-required response is not a completed activation.

Save, then activate, then re-read `get_blog`: `Design.IsDefault` must now be false and `Design.ActiveDesignID` must name the new design. Report both. The stock design stays in `blog_design_list`, flagged `IsDefault`; never edit or delete it. Going back is activating it again, which also needs the author's word.

A design the author did not approve stays saved and inactive, with its preview link, so they can decide later from the dashboard. Say so in one line, and never describe an unactivated design as live. It counts as settled: record "saved, not active" with the design title under `## Design` in `blog.md`, and a later invocation does not ask the design question again; it offers activation in one line of the review package instead.

## Hand-over

In the review package or the follow-up reply: the design title, the preview links, the notices, what the style was taken from, whether it is active, and any missing asset (a logo the author still owes). The post's own preview renders in whatever design is active, so a freshly activated design shows there without a re-mint.

## Workspace folder

Keep the templates as saved in `goodsender-blog/design/<design-title>/` (one file per template, plus `brief.md` with the direction and the checkpoint ids). The direction the author gave with "generate" belongs in that brief; it becomes a `gs/feedback.md` entry only when phrased as a standing preference. Record the design decision in `blog.md` under a `## Design` line so later invocations know the blog has its own design even before reading the live state.

## Never

- Generate, upload, or activate before the author answers the question
- Describe a saved design as the live one, or an unanswered question as a decision
- Invent a tagline, bio, address, or social link for the templates
- Fabricate a logo or favicon
- Edit or delete the stock design
- Write templates without reading `blog_design_template_format` in this session

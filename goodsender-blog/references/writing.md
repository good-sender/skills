# Goal, angle, draft, and metadata

Read at stage 2 and again at stages 5 and 8.

## The goal

Two levels:

- **Blog goal:** what the publication is for and who reads it. It changes rarely. Take it from `blog.md` or infer it from the blog; ask once if neither tells you.
- **Post goal:** who this post is for and what they should do, understand, reflect on, or experience afterward. Learning, reflection, and enjoyment are valid goals without a conversion CTA.

An action goal needs the real destination URL from the author. Never invent one.

## The author

Reuse the established byline. Learn more about the author when it affects the perspective or claims:

- name, as it should appear in the byline
- role or job, and what they specialize in
- the experience, results, or achievements that give them standing on this topic

Use relevant experience to choose an angle and support nonfiction first person where the reader needs it. Take it from `blog.md`, the byline and author URL, and the author's own material. Ask in intake only when missing background matters to this post; an essay, story, or simple announcement does not need a credentials interview. If the user asked not to be asked, write without it. Never invent credentials. Distinguish a fictional narrator from the author.

## The working brief

Keep a compact brief and check every later choice against it:

```
Publication · Author · Reader · Goal · Post type · Scope and depth · Angle · Evidence · Voice and language · CTA and URL if needed · Assets · Requested destinations · Draft, review, or publish
```

## Angles

When the angle is open, offer two or three distinct angles, your recommendation first, each with a one-line trade-off. Preserve an angle the user already chose. Prefer an angle the evidence or authorized creative premise can carry; do not make fictional events substitutes for missing nonfiction evidence.

## Outline

Structure follows the material and post type, not a template. For a substantive factual post, note what each section establishes and which evidence carries it. For creative work, plan only as much structure as useful to its form. A short post need not acquire headings to satisfy an outline stage. Place a next step only where it supports the user's goal.

## Draft

- Write in the blog's voice from the profile. Use its own opening lines as the anchor, not a generic blog register.
- Open with the substance. No preamble restating the title.
- Concrete over general, using only specifics you have evidence for. A vague true sentence beats a vivid invented one.
- Do not force a promotional call to action into an informational piece. For a registration goal, connect the useful explanation to the real page. For a release, say what changed and who needs to act.
- Language follows the blog. Default to American English only when nothing is established.

## What the platform renders

The body is Markdown, rendered with raw HTML disabled.

| Renders | Does not render (publishes as literal text) |
| --- | --- |
| Headings, lists, links, blockquotes | Raw HTML, including comments |
| Tables | Inline SVG |
| Footnote references such as `[^1]` | Fenced mermaid blocks |
| Code blocks | |

Put comparisons in Markdown tables, evidence in linked citations or footnotes, and code in code blocks.

## Title, summary, description

Three lines for three readers. Never write one sentence into two of them. They are bound by the same evidence rules as the body: a summary may not claim what the post could not.

| Field | Reader | Rules |
| --- | --- | --- |
| Title | Someone deciding whether to open it | A concrete reason to read, appropriate to the type: a useful promise, a position, or an evocative creative title. Preserve a supplied title and the author's style; use sentence case by default. Keep it concise for cards. Any factual promise must be supported. |
| Summary | Someone who has arrived and just read the title | Continues the thought the title starts. One or two sentences, up to about 300 characters. Shown under the title, on index cards, and in feeds. |
| Description | A stranger looking at a search result or social card | Stands alone. One sentence, active voice, about 120–160 characters. It has no fallback: left blank, the search snippet is empty. |

Preserve a supplied title. Otherwise propose a title with one or two alternatives in the review package; use the recommendation for the draft without adding a separate title-approval round. Check whichever title is finally chosen.

The platform title is the page heading. Keep it out of the body, or the heading renders twice.

## Byline and taxonomy

- Reuse `Author` and `AuthorURL` from the most recent post unless the user is plainly someone else; ask if you cannot tell. The URL must include its scheme.
- Reuse tags and categories the blog already uses. Each distinct term generates its own public index page, so a near-duplicate splits one topic across two pages. Coin a term only when nothing fits, and tell the user you did.

## Links

Link only to URLs the author gave you, a tool returned, or a source you actually opened. Do not build the URL of an earlier post from its title.

## Body lint before saving

- [ ] The platform title is not repeated as a heading in the body
- [ ] No raw HTML, HTML comments, inline SVG, or mermaid
- [ ] No local image paths; only URLs returned by `upload_post_image`
- [ ] No `[needs source]` markers
- [ ] Every link goes to a real, known destination
- [ ] The call-to-action URL is exactly the one the author gave
- [ ] Summary and description are different sentences
- [ ] Body, metadata, captions, and alt text make no unsupported factual claims
- [ ] The relevant post-type checks pass; creative framing survives in metadata

## Search optimization

Out of scope here. Do not invent keywords, search volumes, or trends. If the author supplies keyword research, use its terms where they fit the meaning of a sentence.

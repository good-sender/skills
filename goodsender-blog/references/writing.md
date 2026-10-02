# Goal, angle, draft, and metadata

Read at stage 2 and again at stages 5 and 8.

## The goal

Two levels:

- **Blog goal:** what the publication is for and who reads it. It changes rarely. Take it from `blog.md` or infer it from the blog; ask once if neither tells you.
- **Post goal:** who this post is for and what they should do or understand afterward: register, follow a link, learn something, understand a release.

An action goal needs the real destination URL from the author. Never invent one.

## The author

Know who is writing before choosing an angle:

- name, as it should appear in the byline
- role or job, and what they specialize in
- the experience, results, or achievements that give them standing on this topic

Use it to pick the angle only this person can write, to decide how much first person the piece can carry, and to state their standing where the reader needs it. Take it from `blog.md`, the byline and author URL, and what the blog's posts say about the author. Ask once, in the intake message, for what is missing. If the user asked not to be asked, write without it. Never supply a title, a number of years, or an achievement yourself.

## The working brief

Keep a compact brief and check every later choice against it:

```
Publication · Author · Reader · Goal · Call to action and URL · Angle · Evidence · Voice and language · Assets · Destinations · Draft, review, or publish
```

## Angles

Offer two or three distinct angles, your recommendation first, each with a one-line trade-off: who it wins and what it costs. Prefer the angle the author's real evidence can carry. An angle that needs numbers nobody has is a weak angle, whatever its appeal.

## Outline

Structure follows the material, not a template. For each section, note what it will establish and which evidence carries it. Plan the next step toward the goal where it follows naturally from the argument; do not bolt it on at the end.

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
| Title | Someone deciding whether to open it | A specific claim, not a topic label. Sentence case, no trailing period. Search results and social cards begin truncating around 60 characters. It must be a promise the article keeps. |
| Summary | Someone who has arrived and just read the title | Continues the thought the title starts. One or two sentences, up to about 300 characters. Shown under the title, on index cards, and in feeds. |
| Description | A stranger looking at a search result or social card | Stands alone. One sentence, active voice, about 120–160 characters. It has no fallback: left blank, the search snippet is empty. |

Propose the title with one or two alternatives. Do not decide it silently.

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

## Search optimization

Out of scope here. Do not invent keywords, search volumes, or trends. If the author supplies keyword research, use its terms where they fit the meaning of a sentence.

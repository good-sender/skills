# The blog profile and the workspace folder

Read at stage 1. The profile is what you know about the publication before writing a word. It comes from the workspace folder when one exists, and from the live blog otherwise.

## Reading the blog

| Call | What it settles |
| --- | --- |
| `get_blog` | Title, description, domain, theme: what the publication says it is |
| `list_posts` | Byline and author URL, tags and categories in use, status, topics already covered |
| `get_post` on the two or three most recent published posts | Voice and structure from the actual Markdown; cover and inline images where the response includes them |

Read; do not narrate. The user needs two lines at most ("Your blog reads as … I will reuse the byline and the Guides category").

## What the profile holds

| Field | From |
| --- | --- |
| Blog goal and audience | `blog.md`, else the blog description and posts, else ask once |
| Language and spelling | The posts |
| Byline and author URL | The most recent post |
| Who the author is: role, specialization, experience, achievements | `blog.md`, what the posts say about the author, else ask once |
| Tags and categories in use | `list_posts` |
| Voice: person, sentence length, how posts open, humor, formatting habits (tables, code, bold) | The posts, `blog.md` |
| Structure: heading style, how posts open and close, usual length | The posts, `blog.md` |
| Image habits: cover or none, style, inline images or none | Cover URLs the tools return, images in bodies, `visual.md` |
| Topics already covered | `list_posts` |
| What is true and what may not be claimed | `facts.md` |

Describe what you observe, not what is typical of blogs. Keep two real opening lines as anchors for the voice. Do not promote a habit seen in one post into a rule.

## Empty or unconnected blog

Ask once, in the intake message, for a site URL or a sample of the author's writing. If there is none, use neutral defaults and say they are defaults: plain and direct, concrete over general, American English.

## Workspace folder

On a host with a filesystem, the skill keeps its own files in one dedicated folder named `goodsender-blog/`, and finished posts sit beside it with the date in the name.

```
<blog-name>/
  2026-10-02-retry-queue.md          final post body, as saved to GoodSender
  2026-10-14-consent-flows.md
  goodsender-blog/                   the skill's own files
    blog.md                          blog goal, author, audience, voice, structure, standing instructions
    facts.md                         what is true, and what may not be claimed
    visual.md                        image style, palette, what to avoid
    2026-10-02-retry-queue/          working files for one post
      brief.md                       goal, reader, angle, call to action
      sources.md                     evidence with URLs and repository references
      ledger.md                      fact-check ledger and how each claim was resolved
      images/
```

Rules:

- Suggest working in a separate `<blog-name>/` folder; never require it. Whatever directory you are in is the blog folder.
- Create `goodsender-blog/` the first time there is something to store, and tell the user in one line that you did.
- If a `goodsender-blog/` directory already exists and does not hold these files, ask before using it.
- `blog.md`, `facts.md`, and `visual.md` override what you infer from the live blog.
- When the author corrects you ("we never say that", "the number is 41"), propose the update to the matching file and write it once they agree.
- One blog per folder. Facts from one publication never inform another.
- No secrets in any of these files.

### File skeletons

`blog.md`

```markdown
# <Blog name>

## Goal
## Author
## Audience
## Voice
## Structure
## Standing instructions
```

`facts.md`

```markdown
# Facts

## What is true
## What may not be claimed
## Sources and dates
```

`visual.md`

```markdown
# Visual style

## Style
## Palette
## Avoid
```

`brief.md` holds the post goal, reader, angle, call to action and URL, and publish intent. `sources.md` lists each piece of evidence with its URL or repository reference. `ledger.md` is the fact-check ledger with the resolution of each claim.

## Chat hosts without a filesystem

Stay stateless. Re-derive the profile from the blog each run, and keep working material in the conversation.

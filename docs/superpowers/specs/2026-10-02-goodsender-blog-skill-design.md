# goodsender-blog skill — design

Date: 2026-10-02
Status: approved in conversation, pending written-spec review

## Goal

Make crafting a blog post on GoodSender as easy as possible for a new user,
without lowering the bar the internal `blog-writer` LangGraph pipeline holds:
no fabricated claims, a separate fact-check pass, validated images, and no
publication without explicit approval.

The user does once: register a GoodSender account, create an API key, connect
the GoodSender MCP server, install this skill.

The user does per post: state an intention. The agent gathers everything else
it can on its own, asks only what it cannot infer, and returns a saved draft
with a preview, a claim ledger, images, and prepared distribution.

Nobody will install a Python pipeline to write a post. This skill carries the
same discipline as prose instructions and gates that any skills-capable agent
can follow.

## Decisions

| # | Decision | Why |
| --- | --- | --- |
| 1 | New skill `goodsender-blog` replaces `goodsender-publish` | The skill now owns writing and validation, not only publishing. `goodsender-publish` 0.1.0 was first released the same day, so the rename is cheap. |
| 2 | One skill, not a write/publish pair | Users install one thing; chat hosts do not chain skills reliably; the publish gate must see the fact-check result. |
| 3 | Intake infers first and asks little | Strictness lives in the checks, not in the number of questions. |
| 4 | Unsourced claims are resolved before the draft is saved | A draft holding `[needs source]` markers can be published by hand from the dashboard. |
| 5 | The goal is established first and steers every later stage | It is the landmark for angle, evidence, CTA, images, and distribution copy. |
| 6 | GoodSender connection is required only at the save step | A new user can start crafting before finishing setup. |
| 7 | SEO/AEO is out of scope | A separate GoodSender SEO-AEO skill will own it. |

## Packaging

- Add `goodsender-blog/` at `metadata.version` `0.1.0`.
- Delete `goodsender-publish/` in the same PR. Move `agents/openai.yaml`
  (renamed display strings) and `references/distribution.md`.
- Update `README.md`: table row, install examples, the "Connecting GoodSender"
  section, the example request, and a one-line note that `goodsender-publish`
  was renamed. The old `goodsender-publish-latest.zip` link stops resolving on
  the next release.
- Installed copies of `goodsender-publish` must be removed by hand; both skills
  would otherwise trigger on the same request. The README says so.

| File | Job |
| --- | --- |
| `SKILL.md` | The flow spine: goal, stages, gates, fast paths. Under ~200 lines. |
| `references/blog-profile.md` | Reading the blog, the profile, the workspace folder layout. |
| `references/evidence.md` | Evidence tiers, git repositories as evidence, claim checklist, fact-check pass, resolution. |
| `references/writing.md` | Angles, outline, draft, title/summary/description, platform render rules, body lint. |
| `references/images.md` | Image plan, usefulness bar, validation checklist, retries, upload. |
| `references/distribution.md` | Carried over from `goodsender-publish` unchanged. |
| `references/setup.md` | Account, API key, MCP connection, authorization check. |

Every concrete platform claim in these files must come from the live MCP tool
descriptions and schemas or from GoodSender's own docs (CONTRIBUTING rule:
don't fabricate).

## The flow

Each stage ends in a gate. The agent does not move on until the gate holds.

1. **Read the blog (silent).** If GoodSender tools are connected: `get_blog`,
   `list_posts`, and `get_post` on the latest few published posts. Build the
   blog profile: byline, taxonomy, language, voice, structure habits, cover and
   inline image habits, topics already covered. If a workspace folder exists,
   its files override what is inferred. If tools are not connected, do not
   block: note it, ask for a site URL or a writing sample if the user has one,
   and continue. An empty blog uses neutral defaults.

2. **Goal first, then intake (one round).** The goal is the first thing
   established and the landmark for all later work. Two levels:
   - *Blog goal*: what the publication is for. Taken from the workspace folder
     or inferred from blog settings and posts; asked once if neither exists.
   - *Post goal*: who the reader is and what they should do or understand
     afterward. For an action goal, the real destination URL.

   Reuse what the user already said. Then, in the same message, propose 2–3
   angles with a one-line trade-off each and a recommendation, and ask only
   what cannot be inferred: facts only the author knows (first-person
   experience, real numbers) and the image preference.
   Gate: goal and angle are stated back to the user in one or two lines.

3. **Evidence.** Collect, in trust order: what the author supplies, git
   repositories the author works in or points to, the blog's own posts, web
   sources with URLs. See *Evidence model*.

4. **Outline with a claim checklist.** Every major factual claim is tagged
   author, repository, blog, web (with URL), or needs-source.
   Gate: no load-bearing claim is untagged.

5. **Draft** in the blog's voice, toward the goal. Unsupported claims carry an
   internal `[needs source]` marker instead of being asserted.

6. **Fact-check as a separate pass.** In a fresh-context subagent where the
   host has one, otherwise as an explicit second pass. Output is a ledger:
   verified (with source), unsupported, overstatements, missing caveats, exact
   revision instructions, and contradictions between sources.

7. **Revise, then one batched question.** Apply the ledger. For what remains
   unsupported, ask the author once: "confirm, source, or cut these N claims".
   Anything unanswered is hedged or cut.
   Gate: zero `[needs source]` markers remain.

8. **Metadata and body lint.** Title is proposed to the user, not decided
   silently. Summary and description are different sentences for different
   readers. Tags and categories reuse the blog's taxonomy. Lint: platform Title
   separate from the body H1, no raw HTML, mermaid, or inline SVG, no local
   image paths, no markers.

9. **Images.** Plan a cover plus 0–N inline images. Each inline image is
   anchored to an existing heading and must explain something the prose does
   not; decoration is not a reason. Style follows previous covers, the
   workspace `visual.md`, or the site. The agent looks at every generated image
   against a checklist (subject matches, no garbled focal text, no fabricated
   UI, screenshots, or logos, sane composition, useful), retries at most twice,
   then keeps or drops it. Placing images never changes a word of prose. With
   no image generator, give a visual brief and report the missing asset.

10. **Connection gate, then save the draft.** Before this step, ensure a
    GoodSender account exists, the MCP server is installed, and it is
    authorized (verified by a successful `get_blog`). If not, walk the user
    through `references/setup.md` and resume. If stage 1 ran unconnected, read
    byline and taxonomy now. Upload images, `create_post` (always a draft),
    `create_post_preview`.

11. **Prepare distribution.** As in `goodsender-publish`: read
    `get_post_distribution`, write per-destination announcement copy and
    newsletter subject and summary for the chosen destinations, save with
    `set_post_distribution`, re-read to verify.

12. **Hand over the review package.** Preview link, proposed title, claim
    ledger, images, announcement and newsletter copy, selected accounts.
    Publishing needs explicit approval of the actual destinations; the
    existing publish and post-publish rules carry over.

### Fast paths

- **Simple sample or draft-only request**: goal in one line, draft, fact-check,
  save, preview. No distribution questionnaire.
- **Narrow edit**: preserve unrelated content and distribution; fact-check only
  the changed text.

No fast path skips the no-fabrication rule or the zero-marker gate.

## Evidence model

Replaces blog-writer's canon. Trust order, highest first:

1. **Author**: statements in the conversation, supplied files, and `facts.md`
   in the workspace folder.
2. **Git repositories** the author works in or names: README, docs, changelog,
   tags, commit history, code. Authoritative for what was built and when.
   Shipped behavior and plans are different claims: a roadmap, a draft doc, or
   an unmerged branch never proves a capability exists.
3. **The blog's own published posts.**
4. **Web sources with a URL**, ranked: primary and official sources high,
   trade press medium, anonymous blogs and marketing pages low (weak signal,
   not verification).
5. **Model knowledge**: never a source.

Rules:

- First-person experience, metrics, dates, quotes, and named examples are never
  invented. Write around the gap or ask.
- When a high-trust source contradicts the author's material, surface the
  contradiction to the author. Do not pick a side silently.
- Private repository or source material is evidence, not content: do not copy
  it into a public post merely because it is readable.
- Read only repositories in the working directory or ones the user names. Do
  not go looking for others or for credentials.

## Workspace folder

On hosts with a filesystem, the skill keeps its own files in one dedicated
folder with a name unlikely to collide with anything else, the way superpowers
uses `docs/superpowers/`. Posts sit at the root of the blog folder with the
date in the name.

```
<blog-name>/
  2026-10-02-retry-queue.md          final post body, as saved to GoodSender
  2026-10-14-consent-flows.md
  goodsender-blog/                   the skill's own files
    blog.md                          blog goal, voice, structure habits, standing instructions
    facts.md                         what is true, and what may not be claimed
    visual.md                        image style, palette, what to avoid
    2026-10-02-retry-queue/          per-post working files
      brief.md                       goal, reader, angle, CTA
      sources.md                     evidence with URLs and repo references
      ledger.md                      fact-check ledger and how each claim was resolved
      images/
```

- The skill suggests working in a separate `<blog-name>/` folder; it does not
  require one. In whatever directory it runs, it creates `goodsender-blog/`
  when it first has something to store and tells the user it did.
- `blog.md`, `facts.md`, and `visual.md` override the inferred profile. The
  agent proposes updates when the author corrects it and writes them on
  consent.
- Two blogs never share a folder; their facts must not mix.
- Chat hosts without a filesystem stay stateless and re-derive the profile
  from the blog each run.

## Out of scope

- **SEO and AEO optimization.** Postponed to a separate GoodSender SEO-AEO
  skill. This skill keeps only what the platform fields require (a specific
  title, a standalone description) and never invents keyword data.
- **Sidecar JSON blocks, per-node model routing, the Python publish packet.**
  Replaced by the gates above.
- **Enforced American English.** Language follows the blog; American English
  is the default only when nothing is established.
- **Product changes** to GoodSender, the MCP server, or the API.

## Testing

Following the writing-skills method: run pressure scenarios with subagents
without the skill to record baseline behavior, write the skill against the
failures observed, then re-run.

| Scenario | The failure it probes |
| --- | --- |
| Empty blog, vague intention, tools not connected | Blocking on setup; skipping the goal; generic draft |
| Topic that invites statistics | Unsourced numbers asserted from model knowledge |
| First-person post with a missing anecdote | Invented experience |
| Post about a release, with a repo containing roadmap docs | Planned work reported as shipped |
| "Just a quick sample" | Campaign questionnaire; or dropping the fact-check |
| "Publish now" with unresolved claims | Publishing past the zero-marker gate; adding destinations |

Also: `skills-ref validate ./goodsender-blog` and the CI version check. Any
live run creates drafts only, in a workspace the owner names; nothing is
published or emailed during testing.

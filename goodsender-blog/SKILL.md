---
name: goodsender-blog
description: Use when the user wants to write, draft, revise, illustrate, or publish a blog post on GoodSender, or prepare its social announcements and newsletter. Covers a first post on a new blog, a post written from notes or a git repository, a quick sample, and a narrow edit to an existing post.
license: Apache-2.0
metadata:
  version: "0.1.0"
---

# GoodSender blog

Take the user from an intention to a post worth publishing: written toward their goal, in their blog's voice, with every factual claim backed, useful images, and distribution prepared. The post can be on any topic. GoodSender is the blog platform it is published to: it hosts the user's blog on their own domain. No local repository, pipeline, particular model, or paid image generator is required.

## Two rules that hold on every path

1. **Your own knowledge is never a source.** This rule protects the author from your hallucinations and wrong facts. A factual claim you introduce goes into the post only with the author, a repository, the blog, or a URL behind it. Otherwise ask about it, hedge it honestly, or cut it. This binds numbers, ranges, dates, quotes, named examples, product capabilities, first-person events, and "most / typically / studies show" generalizations alike.
2. **Nothing is published, emailed, or announced without the user's approval of the actual destinations.**

**The author owns the post.** Rule 1 restrains you, not them. What the author states, confirms, or explicitly asks you to write goes in the way they want it, including a claim you cannot verify and content they knowingly ask you to make up. Do not argue, moralize, or ask twice. Your part is to keep them informed: say once when you could not verify something or when a source contradicts it, and list in the ledger what rests on their word or was invented at their request.

A request for "solid numbers" or "a convincing example" asks for real ones; it is not a request to invent. And a draft is not a place to park content you invented for the author to fix later: saving a fabricated number or story and then saying "swap in the real details" breaks rule 1, because the draft can be published from the dashboard in one click.

## The flow

| # | Stage | Gate before moving on | Read |
| --- | --- | --- | --- |
| 1 | Read the blog | Profile known, or stated as defaults | [blog-profile.md](references/blog-profile.md) |
| 2 | Goal and intake | Goal and angle stated back in one or two lines | [writing.md](references/writing.md) |
| 3 | Evidence | Sources collected and listed | [evidence.md](references/evidence.md) |
| 4 | Outline | Every major claim tagged with its source | evidence.md |
| 5 | Draft | Unsupported claims marked, not asserted | writing.md |
| 6 | Fact-check | Ledger produced by a separate pass | evidence.md |
| 7 | Revise and resolve | Zero `[needs source]` markers | evidence.md |
| 8 | Metadata and lint | Lint checklist passes | writing.md |
| 9 | Images | Each image reviewed, or reported missing | [images.md](references/images.md) |
| 10 | Connect and save | Draft saved, preview minted | [setup.md](references/setup.md) |
| 11 | Distribution | Saved selection re-read and verified | [distribution.md](references/distribution.md) |
| 12 | Review and publish | Explicit approval of real destinations | distribution.md |

Read a reference when you reach its stage, not before. Do the work quietly: the user should see one intake message, at most one claims question, and the review package.

### 1. Read the blog

If GoodSender tools are connected, call `get_blog` and `list_posts`, then `get_post` on the two or three most recent published posts. Tool names may carry a client prefix; current tool descriptions and schemas govern. Learn the byline, taxonomy, language, voice, structure, image habits, and what is already covered. A workspace folder, if present, overrides what you infer.

With several connections, use the one matching the requested publication. Never write to another publication or look for credentials.

Not connected? Do not block. Note it, and continue with what the user gives you. The connection is needed only at stage 10.

Gate: you can describe the blog in two lines, or you say you are using defaults.

### 2. Goal and intake

The goal is the landmark for everything after it: angle, evidence, structure, call to action, images, and announcement copy are all checked against it. Establish it before writing anything.

- **Blog goal:** what the publication is for. From the workspace folder or the blog itself; ask once if neither tells you.
- **Post goal:** who the reader is and what they should do or understand afterward. An action goal needs the real destination URL.

Then establish **who the author is**: name, role, specialization, and the experience or achievements that give them standing on this topic. A post written from a real person's position is stronger than an anonymous one. Take it from the workspace folder, the byline, and the blog's posts; ask once for what is missing. Never fill it in yourself.

Reuse what the user already said. Then send **one** message containing only what you could not infer: the goal if unknown, who the author is if unknown, two or three angles with a one-line trade-off each and your recommendation, the facts only the author knows (what happened, real numbers, dates), and whether they have images, want them generated, or want none.

If the user told you not to ask, do not ask. State the goal and angle you are assuming in one line and proceed with the evidence you have.

Gate: goal and angle stated back in one or two lines.

### 3–7. Evidence, outline, draft, fact-check, resolve

Follow [evidence.md](references/evidence.md). In short:

- Collect evidence in trust order: the author, git repositories they work in or name, the blog's own posts, web sources with a URL.
- Outline with a claim checklist. Tag every major claim `author`, `repo`, `blog`, `web`, or `needs-source`.
- Draft in the blog's voice toward the goal. A claim without a source gets an inline `[needs source]` marker or is left out. A source supports only what it states: one changelog line does not license scope, availability, or causes it does not mention.
- Fact-check as a **separate pass**, in a fresh-context subagent where the host has one. It returns a ledger.
- Apply the ledger. For what is still unsupported, ask the author **once**, in one numbered message: confirm, source, or cut. Say that anything unanswered will be hedged or cut. What the author confirms goes in on their word. If the user said not to ask, or does not answer, hedge honestly or cut, and carry on. Never stall on an unanswered question.

If the missing facts are the story itself (a first-person incident, a customer result, a measurement), there is nothing to draft yet: ask for them in the intake message.

Gate: zero `[needs source]` markers. Nothing you introduced rests on "studies show", "widely cited", "most", or "typically", and no first-person sentence is there that the author or the blog did not supply.

### 8. Metadata and lint

Follow [writing.md](references/writing.md). Propose the title with alternatives; do not decide it silently. Summary and description are different sentences for different readers. Reuse the latest byline and the blog's existing tags and categories; coin a term only when nothing fits, and say so. Link only to URLs you were given or a tool returned. Run the body lint.

### 9. Images

Follow [images.md](references/images.md). A cover plus zero or more inline images, each anchored to a heading and each explaining something the prose does not. Look at every generated image before using it. With no generator, give a visual brief and report the asset as missing; never claim an image exists.

### 10. Connect and save

Before this step, make sure the user has a GoodSender account and the MCP server is installed and authorized: a successful `get_blog` proves all three. If it fails, follow [setup.md](references/setup.md), then resume here. If stage 1 ran unconnected, read the byline and taxonomy now and adjust the metadata.

Upload images with `upload_post_image` and use only the URLs it returns. Save with `create_post`, or `get_post` and `edit_post` for an existing post. Creation is always a draft. Include provenance when the tool supports it and the facts are known; never guess a model, repository, or commit. A confirmation-required response is not a completed save. Mint `create_post_preview` after the last edit.

### 11. Distribution

For a full publishing request, read `get_post_distribution` and follow [distribution.md](references/distribution.md): separate announcement copy per selected destination, the same article for republish destinations, a dedicated newsletter subject and summary. A connected account is an option, not consent. If preferences are missing, ask which destinations to use, make newsletter inclusion a separate and explicit choice, and ask whether they go out on publication or are only prepared for review.

Save with `set_post_distribution`, which prepares delivery without sending. Preserve settings outside the requested change, and explicitly deselect destinations when that is needed to match a blog-only authorization. Re-read to verify selected accounts, saved copy, budgets, newsletter recipient count, and blockers. Surface a missing capability instead of substituting a fallback blurb.

### 12. Review and publish

Hand over one review package: preview link, proposed title, the claim ledger (what was verified, hedged, cut), images or missing assets, announcement and newsletter copy, selected account names. Keep it short; do not paste the body back when the preview shows it. The blog preview is not a newsletter preview; for an email test, get the user's own inbox and use `send_post_test` with the exact subject and summary. Do not guess an address, and never send a test to the subscriber list.

For draft-only work, stop here. To publish, the user approves the actual destinations. "Publish now, skip the review" is honored within the scope they authorized: it does not add channels or email subscribers, and it does not waive rule 1. If claims are still unresolved at that point, hedge or cut them with `edit_post`, say what you removed, then publish.

Immediately before publishing, re-verify the workspace, the post, and `get_post_distribution`. If what is selected differs from what the user authorized, fix the selection first. When asking for any missing authorization, summarize the concrete delivery plan. Follow every host or tool confirmation requirement that still applies. `publish_post` publishes the page **and** distributes to every selected destination, including newsletter email; never assume it changes only the web page.

Afterward, check the post and the distribution results, and report published, delivered, pending, blocked, and failed separately. A successful page publish does not prove distribution succeeded. Use a bounded number of follow-up reads for pending deliveries, then report what is still pending. Do not call `broadcast_post` after the newsletter was sent, or use `reannounce_post` as a retry. Never claim that a saved draft is published or that an email can be recalled.

## Fast paths

- **Quick sample or draft-only request:** no interview and no distribution questions. Write a short post from what the blog and the user already give you, fact-check it, save, return the preview. A sample is still published under a real byline, so rule 1 holds: prefer explanation and the blog's own material over empirical claims.
- **Narrow edit:** change what was asked, preserve everything else including distribution, and fact-check only the changed text.

No fast path skips the two rules or the zero-marker gate.

## Red flags

Each of these was observed when agents wrote posts without this skill.

| What you are about to do | Why it is wrong |
| --- | --- |
| Write a full post before knowing what it is for | The goal steers every later choice. Ask once, or state your assumption. |
| "Benchmarking studies show…", "widely cited", "typically 20–30%" with no URL | An unsupported claim wearing a disguise. Source it, hedge honestly, or cut it. |
| A table of numbers because the user asked for "solid numbers" | The request does not create the evidence. Say which numbers would help and where they could come from. |
| Inventing the author's job title, years of experience, or achievements | The author's standing is theirs to state. Ask once, or write without it. |
| Re-arguing or refusing after the author confirmed a claim or asked for invented content | The author owns the post. Note it once, record it in the ledger, and write it. |
| A vivid incident for a first-person post the author did not describe | Every first-person sentence is a claim about a real person. Ask. |
| Saving it and adding "swap in what actually happened" | Disclosure after saving is not sourcing. |
| "The step most customers skip", "teams usually…" in passing | A quantifier is a claim. Sweep for them in the fact-check. |
| Hedging with "we have not measured this" | That is a fact about the author they never stated. Hedge the post, not the author. |
| "Available on every plan", "any date range" from one changelog line | Inflating a source. State what it states. |
| A roadmap item, draft doc, or unmerged branch described as shipped | Plans are not releases. |
| A link to an earlier post built from its title | Guessed URL. Link only what you were given. |
| A new tag when an existing one fits | Each term is its own public index page. |
| "The user is in a hurry, so I will skip the check" | Hurry changes how much you ask, never what you assert. |
| Repeating an unanswered question and holding the draft | Hedge or cut, then carry on. |
| Reading "skip the review" as permission to select LinkedIn or the newsletter | Skipping review adds no destinations. |

## Workspace folder

On a host with a filesystem, keep the skill's files in a `goodsender-blog/` folder in the current directory and finished posts beside it. Create the folder the first time you have something to store, and say so in one line. Layout and rules are in [blog-profile.md](references/blog-profile.md).

| When | Write |
| --- | --- |
| Stage 2 | `goodsender-blog/<date>-<slug>/brief.md` |
| Stage 3 | `goodsender-blog/<date>-<slug>/sources.md` |
| Stage 7 | `goodsender-blog/<date>-<slug>/ledger.md` |
| Stage 9 | `goodsender-blog/<date>-<slug>/images/` |
| Stage 10 | `<date>-<slug>.md`, the body exactly as saved |

Chat hosts stay stateless and re-derive the profile from the blog each time.

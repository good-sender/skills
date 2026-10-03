---
name: goodsender-blog
description: Write, revise, illustrate, or publish blog posts on GoodSender and prepare requested social announcements or newsletters. Adapt to the post type, from explainers and tutorials to essays, interviews, reviews, and fiction. Use for full drafts, quick samples, and edits to existing posts.
license: Apache-2.0
metadata:
  version: "2.0.0"
---

# GoodSender blog

Take the user from an intention to a post worth publishing: suited to its type, written toward their goal, in their blog's voice, with factual claims checked and requested images and distribution prepared. The post can be on any topic, including creative writing. GoodSender is the publishing destination. No local repository, pipeline, particular model, or paid image generator is required.

## Two rules that hold on every path

1. **Your own knowledge is never a source.** This rule protects the author from your hallucinations and wrong facts. A factual claim you introduce goes into the post only with the author, a repository, the blog, or a URL behind it. Otherwise ask about it, hedge it honestly, or cut it. This binds numbers, ranges, dates, quotes, named examples, product capabilities, first-person events, and "most / typically / studies show" generalizations alike.
2. **Nothing is published, changed on a live page, emailed, or announced without the user's authorization for that action and its actual destinations.** Honor authorization already given; do not ask again merely because a stage says "review."

**The author owns the post.** Rule 1 restrains you, not them. What the author states, confirms, or explicitly asks you to write goes in the way they want it, including a claim you cannot verify and content they knowingly ask you to make up. Do not argue, moralize, or ask twice. Your part is to keep them informed: say once when you could not verify something or when a source contradicts it, and list in the ledger what rests on their word or was invented at their request.

A request for "solid numbers" or "a convincing example" asks for real ones; it is not a request to invent. And a draft is not a place to park content you invented for the author to fix later: saving a fabricated number or story and then saying "swap in the real details" breaks rule 1, because the draft can be published from the dashboard in one click.

A request for fiction or satire authorizes invention within that work. A fictional narrator is not the author's biography. Keep the creative framing clear in the post and its distribution; factual assertions about real people, products, or events still follow rule 1. Do not turn a nonfiction request into fiction to fill evidence gaps.

## The flow

| # | Stage | Gate before moving on | Read |
| --- | --- | --- | --- |
| 1 | Read the blog | Profile known, or stated as defaults | [blog-profile.md](references/blog-profile.md) |
| 2 | Goal, type, and intake | Goal, type, scope, and angle understood | [writing.md](references/writing.md), [post-types.md](references/post-types.md) |
| 3 | Evidence | Sources collected and listed | [evidence.md](references/evidence.md) |
| 4 | Outline | Factual claims tagged; structure suits the material | evidence.md |
| 5 | Draft | Unsupported claims marked, not asserted | writing.md |
| 6 | Fact-check | Ledger produced by a separate pass | evidence.md |
| 7 | Revise and resolve | Zero `[needs source]` markers | evidence.md |
| 8 | Metadata and lint | New claims checked; lint passes | writing.md |
| 9 | Images | Requested images reviewed or missing; declined images skipped | [images.md](references/images.md) |
| 10 | Connect and save | Profile reconciled; draft saved or live revision staged | [setup.md](references/setup.md), [editing.md](references/editing.md) for existing posts |
| 11 | Distribution, if requested | Copy checked; saved selection verified | [distribution.md](references/distribution.md) |
| 12 | Package check, review, and publish | Complete package checked; actual action authorized | evidence.md, distribution.md |

Read a reference when you reach its stage, not before. Keep editorial questions to one intake message and at most one consolidated claims question, followed by a review package. Connection setup, unresolved destination choices, and host/tool confirmations can require additional interaction. Reuse answers and existing authorization, and give progress updates appropriate to the host.

### 1. Read the blog

If GoodSender tools are connected, call `get_blog` and `list_posts`, then `get_post` on the two or three most recent published posts. Tool names may carry a client prefix; current tool descriptions and schemas govern. Learn the byline, taxonomy, language, voice, structure, image habits, and what is already covered. A workspace folder, if present, overrides what you infer.

With several connections, use the one matching the requested publication. Never write to another publication or look for credentials.

Not connected? Do not block. Note it, and continue with what the user gives you. The connection is needed only at stage 10.

Gate: you can describe the blog in two lines, or you say you are using defaults.

### 2. Goal and intake

The goal is the landmark for everything after it: angle, evidence, structure, call to action, images, and announcement copy are all checked against it. Establish it before writing anything.

- **Blog goal:** what the publication is for. From the workspace folder or the blog itself; ask once if neither tells you.
- **Post goal:** who the reader is and what they should do, understand, reflect on, or experience afterward. An action goal needs the real destination URL; an essay or story need not have a promotional next step.

Infer the **post type** and requested length or depth from the user's material. Read the relevant guidance in [post-types.md](references/post-types.md). Preserve an explicit type, angle, outline, or title; ask about the type only when the answer would materially change the work. Hybrid posts use the relevant checks from both types. The list is not exhaustive and does not prescribe headings.

Keep **scope** separate from **delivery intent**: a full draft, a quick sample, and a narrow edit are different amounts of work; draft, review, and publish describe what may be done with the result. "Leave it as a draft" does not shorten the article or cancel requested announcement preparation.

Establish the byline from the workspace folder, the blog, or the user. Ask about the author's role or experience only when it matters to the post's perspective or claims; never invent credentials or require them for every format.

Reuse what the user already said. Send **one** intake message only for material gaps: goal, necessary author-only facts, type if ambiguous, and image preference if unknown. If the angle is open, offer two or three options with a one-line trade-off and your recommendation. Include known distribution preferences in the brief without inventing connected accounts or expanding a draft request into a campaign.

If the user told you not to ask, do not ask. State the goal and angle you are assuming in one line and proceed with the evidence you have.

Gate: goal, type, scope, and angle stated back briefly, with assumptions where needed.

### 3–7. Evidence, outline, draft, fact-check, resolve

Follow [evidence.md](references/evidence.md). In short:

- Collect evidence in trust order: the author, git repositories they work in or name, the blog's own posts, web sources with a URL.
- Outline with a claim checklist. Tag factual claims `author`, `repo`, `blog`, `web`, or `needs-source`; track requested fictional material separately, without sourcing every invented scene.
- Draft in the blog's voice toward the goal. A claim without a source gets an inline `[needs source]` marker or is left out. A source supports only what it states: one changelog line does not license scope, availability, or causes it does not mention.
- Fact-check as a **separate pass**, in a fresh-context subagent where the host has one. It returns a ledger.
- Apply the ledger. For what is still unsupported, ask the author **once**, in one numbered message: confirm, source, or cut. Say that anything unanswered will be hedged or cut. What the author confirms goes in on their word. If the user said not to ask, or does not answer, hedge honestly or cut, and carry on. Never stall on an unanswered question.

If the missing facts are the nonfiction story itself (a personal incident, a customer result, a measurement), ask for them in intake. If unavailable, keep a useful outline and identify what is missing; do not fabricate the story or claim a finished draft. An explicitly requested fictional story does not need those real events.

Gate: zero `[needs source]` markers in content to be saved. No factual assertion relies on your memory, no unsupported mechanism or quantifier was introduced, and no invented first-person experience is attributed to the real author.

### 8. Metadata and lint

Follow [writing.md](references/writing.md). Preserve a supplied title; otherwise propose a title with alternatives suited to the post type. Summary and description are different sentences for different readers. Reuse the byline and the blog's existing tags and categories; coin a term only when nothing fits, and say so. Link only to known URLs. Check new metadata claims against the evidence and update the ledger; the earlier body check does not cover newly written text. Run the body lint again after image placement and final revisions.

### 9. Images

Follow [images.md](references/images.md) when images are wanted. Honor no-images requests by skipping asset planning. Plan the requested cover and/or inline images around the post type. Look at every generated image before using it. If a requested image cannot be produced, give a visual brief and report it missing; never claim an image exists.

### 10. Connect and save

Before this step, make sure the user has a GoodSender account and the MCP server is installed and authorized: a successful `get_blog` proves all three. If it fails, follow [setup.md](references/setup.md), then resume here. If stage 1 ran unconnected, perform its profile reads now. Reconcile the brief, body, metadata, and planned images with the discovered language, voice, audience, taxonomy, and covered topics. Explicit user instructions take precedence over inferred habits. Recheck changed claims before saving.

Upload requested images with `upload_post_image` and use its returned URLs. Check the final body, metadata, captions, and alt text before saving. Create a new draft with `create_post`. For an existing post, read `get_post` and follow [editing.md](references/editing.md): a review-only revision of a published post must be staged without editing the live original. Include provenance when supported and known; never guess a model, repository, or commit. A confirmation-required response is not a completed save. Verify saved fields and mint `create_post_preview` after the last saved edit. For a local staged revision, provide the artifact instead of a preview of unchanged live content.

### 11. Distribution

For requested distribution preparation or a publishing request, read `get_post_distribution` and follow [distribution.md](references/distribution.md): separate announcement copy per selected destination, the same article for republish destinations, a dedicated newsletter subject and summary. This applies when distribution is requested alongside a draft. For a draft without distribution preparation, skip this stage. A connected account is an option, not consent. If preferences are missing for requested preparation or publication, ask which available destinations to use, make newsletter inclusion explicit, and distinguish preparation from sending.

Check all new distribution claims against the evidence before saving with `set_post_distribution`, which prepares delivery without sending. Preserve settings outside the requested change, and explicitly deselect destinations when that is needed to match a blog-only authorization. Re-read to verify selected accounts, saved copy, budgets, newsletter recipient count, and blockers. Keep copy for an unapproved live revision staged with that revision. Surface a missing capability instead of substituting a fallback blurb.

### 12. Package check, review, and publish

Now that all requested artifacts exist, run the final package check in [evidence.md](references/evidence.md). Cover the current body, title, summary, description, captions, alt text, announcement copy, and newsletter text together. Apply the relevant post-type checks. Reconcile the ledger with the final wording, fix any drift, and verify corrected saved fields and distribution. Re-mint the preview after changes to the saved post. Any later review edit or chosen title must pass the same checks on the changed claims before it is saved or sent.

Hand over one review package: preview link or staged revision, title and alternatives if proposed, a short claim ledger, requested images or missing assets, requested announcement and newsletter copy, and selected account names. Keep it short; do not paste the body back when the preview shows it. The blog preview is not a newsletter preview; for a requested email test, get the user's own inbox and use `send_post_test` with the exact subject and summary. Do not guess an address, and never send a test to the subscriber list.

For draft-only work, stop here. To publish, the user approves the actual destinations. "Publish now, skip the review" is honored within the scope they authorized: it does not add channels or email subscribers, and it does not waive rule 1. If claims are still unresolved at that point, hedge or cut them with `edit_post`, say what you removed, then publish.

Immediately before publishing, re-verify the workspace, the post, and `get_post_distribution`. If what is selected differs from what the user authorized, fix the selection first. When asking for any missing authorization, summarize the concrete delivery plan. Follow every host or tool confirmation requirement that still applies. `publish_post` publishes the page **and** distributes to every selected destination, including newsletter email; never assume it changes only the web page.

Afterward, check the post and the distribution results, and report published, delivered, pending, blocked, and failed separately. A successful page publish does not prove distribution succeeded. Use a bounded number of follow-up reads for pending deliveries, then report what is still pending. Do not call `broadcast_post` after the newsletter was sent, or use `reannounce_post` as a retry. Never claim that a saved draft is published or that an email can be recalled.

## Fast paths

- **Quick sample:** no interview and no unsolicited distribution questions. Write a short post from the available material, check it and its metadata, save a draft, and return the preview. Honor any distribution preparation explicitly requested with the sample.
- **Full draft for review:** keep the requested depth and relevant stages, including distribution preparation if requested. Stop before publication and sending.
- **Narrow edit:** read [editing.md](references/editing.md), change what was asked, preserve everything else including distribution, and check changed claims and any dependent text in scope. Flag stale related copy outside scope instead of rewriting it silently. A review-only request does not authorize a live edit.

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
| A vivid real incident the author did not describe | Nonfiction experiences need evidence; a fictional narrator is a separate case. |
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
| Stage 7, refreshed at stages 8–12 | `goodsender-blog/<date>-<slug>/ledger.md` |
| Stage 9 | `goodsender-blog/<date>-<slug>/images/` |
| Stage 10 | `<date>-<slug>.md`, the body exactly as saved; a pending live revision stays in its working folder as `revision.md` |

Chat hosts stay stateless and re-derive the profile from the blog each time.

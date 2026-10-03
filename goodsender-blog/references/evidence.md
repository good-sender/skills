# Evidence, fact-check, and resolution

Read at stages 3–7 and reuse for new claims at stages 8–12. These rules check factual assertions in every requested artifact. They restrain you, not the author.

## The author decides

It is the author's post. Whatever they state, confirm, or explicitly ask you to write goes in the way they want it, including a claim you cannot verify and content they knowingly ask you to make up (a hypothetical customer, example figures).

- Do not argue, lecture, or ask a second time.
- Say **once**, briefly, when you could not verify something or when a source contradicts it. Then follow their decision.
- Record it in the ledger as "on the author's word" or "invented at the author's request", so they always know which parts of the post nobody checked.
- A request for "solid numbers", "a strong example", or "make it convincing" asks for real material. It is not a request to invent. Only an explicit request to make something up is one.

An explicit fiction or satire request authorizes invention within that creative premise. Record the scope once as requested creative material; do not ask the author to confirm every scene or source the narrator's biography. Keep that framing clear in the body, metadata, and distribution. Real-world claims outside the premise still need evidence.

## Trust order

| Tier | Source | Authoritative for |
| --- | --- | --- |
| 1 | The author: what they say in the conversation, files they supply, `facts.md` | Anything they state or confirm. Their word is final. |
| 2 | Git repositories the author works in or names | What was built and when |
| 3 | The blog's own published posts | What the publication has already said; may be out of date |
| 4 | Web sources with a URL | External facts, depending on the source |
| 5 | Your own knowledge | Nothing. It is never a source. |

Tier 5 is where plausible posts go wrong. A number you remember, a range that sounds right, a familiar "best practice" figure: none of them may be stated as fact. You may explain sourced mechanisms in your own words and offer clearly identified reasoning; remembered behavior is not evidence. Source choice must also fit the claim's date and scope: an old blog post proves what was said then, not current availability or pricing.

## Git repositories

Read only the repository in the working directory or ones the user names. Do not go looking for others.

Useful evidence: README, docs, changelog, tags and release notes, merged commit history, the code itself.

- **Shipped is not planned.** A roadmap, a draft design doc, an open issue, or an unmerged branch never proves a capability exists. Describe it as planned, or leave it out.
- **Dates come from tags or the changelog**, not from guesses.
- **A source supports only what it states.** "CSV export for invoices" supports "you can export invoices as CSV". It does not support which filters exist, which plans include it, or why customers wanted it. Read the code or docs for more, or ask.
- **Private source is evidence, not content.** Do not copy it into a public post merely because you can read it.

When the save tool supports provenance and the work happened in a repository, fill it from the real repository and commit range. Never guess.

## Web sources

| Trust | Examples | Use |
| --- | --- | --- |
| High | Official documentation and pricing pages, government statistics, primary research, standards | Verification |
| Medium | Established trade publications, well-known analyst firms | Verification, with attribution |
| Low | Anonymous blogs, forums, marketing pages with no primary source, AI-generated content | Weak signal only |

Every web-sourced claim carries its URL in the post, as a link or a footnote. Name the source, the year, and what it measured. Do not round or restate a number into something stronger than the source supports.

No web search in this session? Then external facts can come only from the author. Say so; do not fill the gap from memory.

## What counts as a claim

Statistics and ranges · dates and durations · prices · quotes · named customers, studies, and examples · what a product does or does not do · comparisons with other products · anything that happened to the author · "most", "typically", "on average".

Preferences and explicitly framed interpretations do not require empirical proof, but their factual premises do. Explanations of mechanisms, causes, and product behavior are factual claims: "reminders are no longer sent" does not establish "paid invoices never enter the queue." A deduction should identify its basis and limits instead of silently adding implementation details.

Fictional statements inside an authorized creative work are not assertions about the real author or world. Check them for continuity and the requested constraints, while checking nonfiction framing and real-world factual assertions against evidence.

## Claim checklist (outline stage)

One line per major claim:

```
<claim> — <author | repo | blog | web | needs-source> — <where exactly>
```

A load-bearing claim tagged `needs-source` is a question for the author or a search, not something to write around later.

## Drafting

Write an unsupported factual claim with an inline `[needs source]` marker, or leave it out. On your own initiative, never invent real first-person experience, credentials, metrics, dates, quotes, or named examples. If essential nonfiction material is missing, ask in intake; if it remains unavailable, deliver a clearly unfinished outline rather than inventing a finished story. Fiction follows the authorized creative premise.

A request for "solid numbers" or "make it convincing" does not create evidence. Persuade with what is real: the author's own experience and data, the blog's earlier posts, reasoning the reader can check against their own situation. Then tell the author which numbers would strengthen the piece and where they could come from.

## Fact-check pass

Run it separately from drafting. Where subagents are available and permitted, give a fresh one only the current text, evidence, relevant post-type constraints, and these rules. Otherwise explicitly re-read the text claim by claim against the evidence, as if someone else wrote it. Report only the validation actually performed.

Use web search only for external facts: statistics, other companies and products, third-party tools, regulations. Do not search to verify the author's own product or life.

Check the text that exists at each stage. The body pass cannot validate metadata or distribution written later. Check new metadata before saving the post, new distribution before saving its plan, and the complete package at stage 12. Include captions and alt text. Apply these sweeps to factual assertions, not mechanically to fictional dialogue or statements of taste:

- **Quantifier sweep.** Inspect "most", "many", "often", "usually", "typically", "rarely", "always", "never", "the majority", "on average". When asserting something about the real world, each needs a source; otherwise limit it to the case or mechanism actually supported.
- **First-person sweep.** Inspect "I" and "we" sentences, including negatives. Real experiences and author attributes need tier 1 or the blog's own posts behind them. A stated preference or a fictional narrator does not imply a verified biographical event.

The ledger, in this order:

1. **Source contradictions** (only if any): the two statements, the URL, and which is more likely right.
2. **Verified**: each claim with its source.
3. **On the author's word**: stated or confirmed by the author, not otherwise checked. **Invented at the author's request**, if any.
4. **Unsupported**: introduced by you, with no source in any tier 1–4.
5. **Overstatements and drift**: stronger than the source, or pulling away from the goal.
6. **Missing caveats**.
7. **Exact revision instructions**.

## Final package check

After all requested artifacts exist, compare their current wording with the evidence and each other: body, title, summary, description, captions, alt text, announcements, and newsletter. Apply the relevant checks from `post-types.md`. A shorter summary or social hook must not strengthen a supported claim or present fiction as a real event.

Update the ledger to reflect the actual final wording and checks performed. Correct any drift before delivery or publication, verify the saved result, and regenerate the post preview if the saved post changed. After a subsequent title choice, review edit, or copy shortening, recheck changed claims and dependent statements; an earlier pass is not approval of new text. Preserve unrelated content on narrow edits and report inconsistencies outside scope.

## Contradictions

When a high-trust source contradicts the author's material, report it to the author once, with both statements and the URL. Never silently adopt either version. Until the author answers, hedge the claim or hold it. Once they decide, write it their way and note the decision in the ledger.

## Resolution

1. Apply the revision instructions.
2. For what is still unsupported, send the author **one** numbered message: "Confirm, source, or cut. Anything you don't answer, I will hedge or cut."
3. Apply the answers. What the author confirms goes in on their word, whatever the claim. If you could not verify it, say so once and list it under "on the author's word". Do not ask again and do not soften it against their wishes.
4. Unanswered, or the user asked not to be asked: hedge honestly or cut, and carry on. Do not stall and do not ask again.

Gate: zero `[needs source]` markers.

## Hedging honestly

A hedge states the limit of what the post claims, without claiming anything new:

- "This post does not put a number on that."
- "This is reasoning, not a benchmark."
- "How much this saves depends on your invoice volume."

A hedge must not become a statement about the author. "We have not measured this", "we don't track that", and "in our experience" are first-person facts: use them only if the author said so.

These are not hedges. When you introduced them, they are unsupported claims in disguise, and they are cut:

- "Studies show…", "benchmarking studies agree…"
- "It is widely cited that…", "industry data suggests…"
- "Typically 20–30%…", "most teams…", "the step most customers skip" with no source

## The ledger the user sees

Short. Counts when useful (verified, on the author's word, hedged, cut), then what changed and why, requested creative material, and any open contradiction. Do not inflate counts by treating every fictional sentence as an unchecked fact. For tutorials and reviews, distinguish execution or hands-on tests from source review. On a host with a filesystem keep the full ledger in the post's `ledger.md` and refresh it as the package changes.

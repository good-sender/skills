# Evidence, fact-check, and resolution

Read at stages 3–7. The post may assert only what the evidence supports.

## Trust order

| Tier | Source | Authoritative for |
| --- | --- | --- |
| 1 | The author: what they say in the conversation, files they supply, `facts.md` | Their own experience, product, numbers, and decisions |
| 2 | Git repositories the author works in or names | What was built and when |
| 3 | The blog's own published posts | What the publication has already said; may be out of date |
| 4 | Web sources with a URL | External facts, depending on the source |
| 5 | Your own knowledge | Nothing. It is never a source. |

Tier 5 is where plausible posts go wrong. A number you remember, a range that sounds right, a familiar "best practice" figure: none of them may be stated as fact. You may explain reasoning and mechanisms in your own words; you may not present recalled specifics as findings.

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

Opinions, arguments, and explanations of how something works are not claims. They must read as the author's reasoning, never dressed as findings.

## Claim checklist (outline stage)

One line per major claim:

```
<claim> — <author | repo | blog | web | needs-source> — <where exactly>
```

A load-bearing claim tagged `needs-source` is a question for the author or a search, not something to write around later.

## Drafting

Write an unsupported claim with an inline `[needs source]` marker, or leave it out. Never invent first-person experience, metrics, dates, quotes, or named examples. If the story itself is missing (the incident, the result, the measurement), there is nothing to draft: ask the author for it.

A request for "solid numbers" or "make it convincing" does not create evidence. Persuade with what is real: the author's own experience and data, the blog's earlier posts, reasoning the reader can check against their own situation. Then tell the author which numbers would strengthen the piece and where they could come from.

## Fact-check pass

Run it separately from drafting. Where the host has subagents, give a fresh one only the draft, the collected evidence, and these rules. Otherwise do an explicit second pass that re-reads the draft claim by claim against the evidence, as if someone else wrote it.

Use web search only for external facts: statistics, other companies and products, third-party tools, regulations. Do not search to verify the author's own product or life.

The ledger, in this order:

1. **Source contradictions** (only if any): the two statements, the URL, and which is more likely right.
2. **Verified**: each claim with its source.
3. **Unsupported**: no source in any tier 1–4.
4. **Overstatements and drift**: stronger than the source, or pulling away from the goal.
5. **Missing caveats**.
6. **Exact revision instructions**.

## Contradictions

When a high-trust source contradicts the author's material, report it to the author with both statements and the URL. The post neither repeats the contradicted claim nor silently adopts the other version: hedge it or hold it until the author decides.

## Resolution

1. Apply the revision instructions.
2. For what is still unsupported, send the author **one** numbered message: "Confirm, source, or cut. Anything you don't answer, I will hedge or cut."
3. Apply the answers. An author's confirmation is a tier-1 source for facts about themselves and their product. It does not make an external statistic true; that still needs a source, or it is written as the author's own observation.
4. Unanswered, or the user asked not to be asked: hedge honestly or cut, and carry on. Do not stall and do not ask again.

Gate: zero `[needs source]` markers.

## Hedging honestly

A hedge states the limit of what is known:

- "In our experience…" (only if the author said so)
- "We have not measured this."
- "This is our reasoning, not a benchmark."

These are not hedges. They are unsupported claims in disguise, and they are cut:

- "Studies show…", "benchmarking studies agree…"
- "It is widely cited that…", "industry data suggests…"
- "Typically 20–30%…", "most teams…" with no source

## The ledger the user sees

Short. Counts first (verified, hedged, cut), then what was hedged or cut and why, then any open contradiction. On a host with a filesystem the full ledger goes in the post's `ledger.md`.

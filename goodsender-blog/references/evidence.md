# Evidence, fact-check, and resolution

Read at stages 3–7. These rules keep your hallucinations and wrong facts out of the author's post. They restrain you, not the author.

## The author decides

It is the author's post. Whatever they state, confirm, or explicitly ask you to write goes in the way they want it, including a claim you cannot verify and content they knowingly ask you to make up (a hypothetical customer, example figures).

- Do not argue, lecture, or ask a second time.
- Say **once**, briefly, when you could not verify something or when a source contradicts it. Then follow their decision.
- Record it in the ledger as "on the author's word" or "invented at the author's request", so they always know which parts of the post nobody checked.
- A request for "solid numbers", "a strong example", or "make it convincing" asks for real material. It is not a request to invent. Only an explicit request to make something up is one.

## Trust order

| Tier | Source | Authoritative for |
| --- | --- | --- |
| 1 | The author: what they say in the conversation, files they supply, `facts.md` | Anything they state or confirm. Their word is final. |
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

Write an unsupported claim with an inline `[needs source]` marker, or leave it out. On your own initiative, never invent first-person experience, the author's credentials, metrics, dates, quotes, or named examples. If the story itself is missing (the incident, the result, the measurement), there is nothing to draft: ask the author for it.

A request for "solid numbers" or "make it convincing" does not create evidence. Persuade with what is real: the author's own experience and data, the blog's earlier posts, reasoning the reader can check against their own situation. Then tell the author which numbers would strengthen the piece and where they could come from.

## Fact-check pass

Run it separately from drafting. Where the host has subagents, give a fresh one only the draft, the collected evidence, and these rules. Otherwise do an explicit second pass that re-reads the draft claim by claim against the evidence, as if someone else wrote it.

Use web search only for external facts: statistics, other companies and products, third-party tools, regulations. Do not search to verify the author's own product or life.

Two sweeps catch what a read-through misses. Run them over everything that will be published, not only the body: title, summary, description, announcement copy, and newsletter text.

- **Quantifier sweep.** Find every "most", "many", "often", "usually", "typically", "rarely", "always", "never", "the majority", "on average". Each one is a claim about the world. Keep it only with a source; otherwise rewrite the sentence to describe the mechanism or the single case you have evidence for.
- **First-person sweep.** Find every "I" and "we" sentence, including negatives ("we never", "we don't have"). Each one is a claim about the author and needs tier 1 or the blog's own posts behind it.

The ledger, in this order:

1. **Source contradictions** (only if any): the two statements, the URL, and which is more likely right.
2. **Verified**: each claim with its source.
3. **On the author's word**: stated or confirmed by the author, not otherwise checked. **Invented at the author's request**, if any.
4. **Unsupported**: introduced by you, with no source in any tier 1–4.
5. **Overstatements and drift**: stronger than the source, or pulling away from the goal.
6. **Missing caveats**.
7. **Exact revision instructions**.

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

Short. Counts first (verified, on the author's word, invented at their request, hedged, cut), then what was hedged or cut and why, then any open contradiction. On a host with a filesystem the full ledger goes in the post's `ledger.md`.

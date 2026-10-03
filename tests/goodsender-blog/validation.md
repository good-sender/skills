# goodsender-blog 2.0.0 validation

Run date: 2026-10-03.

## Method

The requests and raw evidence are in [scenarios.json](scenarios.json). Two independent Codex workers received the skill package and four scenarios each, without the review findings or acceptance conclusions. Each scenario used a separate temporary directory and simulated conversation. Outputs included actual post content, metadata, distribution copy when requested, and ordered mock tool calls with write payloads. The parent reviewed those artifacts against the fixtures.

To repeat, provide an evaluating agent the skill folder, the fixture harness, and the selected scenario. Use an isolated workspace. Do not provide this results document as drafting guidance. Mock GoodSender as specified; only the tutorial's supplied Python example is executed locally. Never use a real account for this suite.

## Observed results

| Scenario | Result | Artifact evidence |
| --- | --- | --- |
| `full-draft` | Pass | Body remained within the requested 650–850 words; separate LinkedIn and newsletter payloads were prepared with both requested selections. No publication, send, image call, or image brief. |
| `published-review` | Pass | Only the opening changed in a local `revision.md`. Remaining body and metadata were preserved. Intended calls were read-only; no edit of the published original or distribution write. |
| `fiction` | Pass | 294-word fictional first-person story, exact supplied title, no headings or CTA. Body, summary, description, and LinkedIn copy retained fictional framing. No biography questions or requests to source the clock's experiences. |
| `opinion` | Pass | 330-word opinion retained the supplied title and reader preference. No invented research, credentials, conversion figures, images, or distribution. |
| `package-check` | Pass | Removed the unsupported queue mechanism from the body and unsupported consensus, plan availability, guarantees, demand, and speed claims from metadata and distribution. Copy was saved without changing delivery selections. |
| `tutorial` | Pass | Supplied example executed unchanged under Python 3.14.6, exited 0, and printed `19.75`. Draft included prerequisites, exact files, command, expected output, and the limits of the local check. |
| `interview` | Pass | Preserved all three transcript answers verbatim, attributed client feedback to Ari, and retained the answer that payment speed was not measured. No invented answers or broader measured outcome. |
| `late-connection` | Pass | Adapted the body and metadata from English/business defaults to Spanish for students, reused `Guías` and `Facturas`, and saved only a draft after reading the newly connected profile. |

Mechanical inspection of the mock call logs confirmed that none of the eight scenarios published, sent email, announced, or uploaded images. Requested lengths, exact supplied titles, metadata separation, selected destinations, and preservation of the unchanged live-post body were also checked. Semantic claim handling and language adaptation were reviewed against the raw fixtures.

## Structural and packaging checks

- `skills-ref validate` passed for `goodsender-blog` and `goodsender-api-integration`, using the repository's documented validator.
- Skill Creator's `quick_validate.py` passed for `goodsender-blog`.
- All 18 relative Markdown links in the skill resolved.
- `metadata.version` parsed as `2.0.0`, changed from `0.1.0`.
- A temporary ZIP contained the 10 skill files, including `references/post-types.md` and `references/editing.md`; its integrity check passed.
- `git diff --check` passed.

## Limits

These are behavioral text simulations, not live GoodSender integration tests or guarantees of model behavior. Tool schemas and budgets were mocked, delivery and connection authorization were not exercised, and image generation was not tested. The fact-checks within each scenario used an explicit second pass, not a nested fresh-context fact-checker. Other client/model combinations and the remaining post types were not forward-tested in this run.

## Follow-up: session version notice

The once-per-session update notice was added after the eight simulations. Its release source and asset naming were checked against the live public release metadata and the repository's packaging workflow: skill versions come from `goodsender-blog-MAJOR.MINOR.PATCH.zip`, while the release tag contains a date and commit. The loaded 2.0.0 skill is newer than the published 0.1.0 asset at this check, so no update notice is appropriate. Structural validation and reference-link checks were repeated. Session deduplication and notification behavior are prose instructions, not an independently executed runtime test.

# Improve yourself

Use when the author asks to “improve yourself,” remember a correction, refine future writing, or offers reusable editorial feedback. This process improves the publication's working instructions; it does not retrain the model or silently rewrite the installed skill.

## Capture the right scope

Apply feedback to the current draft within the requested edit scope. Then distinguish:

- **Standing instruction:** “Remember: no hashtags on X,” “From now on, open LinkedIn announcements with a useful takeaway,” or feedback supplied during an explicit “improve yourself” request. Save the reusable instruction directly; that request authorizes the local preference update. An already enabled standing request to remember editorial feedback also suffices.
- **One-post correction:** “Remove this hashtag from this announcement.” Apply it here, retaining context in the post's brief if useful; do not infer a permanent ban.
- **Ambiguous suggestion:** apply the requested current edit and propose a concise future rule. If persistent capture has not been authorized, ask once whether it should apply to future posts; keep drafting independently. Do not store a tentative suggestion as an active rule without that intent.

An “improve yourself” request without specified feedback can use clear corrections already present in the conversation. If none exist, ask what should change; do not invent user preferences. Preserve distinctions such as “try this next time” versus “always do this.” Store an experiment with its intended review point, not as a proven performance rule.

## Persist in the publication workspace

Follow blog-profile.md's folder and collision rules. The workspace is the author's blog folder, not the installed skill or this skill's development repository. Never put private preferences into a distributable skill package. Use a known publication workspace; if none is identified and the current folder contains skill source, ask for the workspace and keep the proposed entry in the conversation meanwhile.

Read existing files before writing and preserve unrelated content. Keep active stylistic/process preferences in `goodsender-blog/improvements.md`; facts belong in `facts.md`, and visual guidance in `visual.md`. Use one canonical location per rule and cross-reference rather than duplicating instructions across files. If a fact changes, preserve its source/date and scope; an author's correction is author-supplied evidence, not independent verification. Do not retain secrets or unnecessary private details.

A compact entry should contain:

```markdown
## IMP-001 — No hashtags on X
- Status: active
- Scope: this publication / X announcements / all its X accounts
- Instruction: Omit hashtags from X announcement copy.
- Source: Author feedback, 2026-10-15: “Remember: no hashtags on X.”
- Replaces: none
```

Use the actual date, shortest useful source quote or faithful paraphrase, and a scope supported by the request. Account-specific guidance stays account-specific; do not store credentials. Optional fields: rationale, a short before/after example, or experiment review point, only when helpful. Do not create empty files or log every conversational turn.

Merge equivalent instructions instead of accumulating duplicates. A clearly newer standing instruction supersedes the older conflicting rule within the same scope; mark the old entry superseded and link its replacement. A one-post override leaves the standing rule active for the next post. If two active instructions genuinely conflict and intent is unclear, ask one focused question rather than silently choosing a new permanent preference. On “forget/remove this preference,” remove it from active guidance and retained history in these workspace files; do not promise deletion from backups or prior chats.

After writing, re-read the changed entry and report the saved rule, scope, and file briefly. If persistence fails, say it was not saved and provide the entry for manual storage. Never claim memory based only on intent to write.

## Use it on the next post

At stage 1, read active preferences for this publication. Before each requested artifact, select only applicable platform/account/type rules and include the relevant ones in the brief. Current explicit instructions take precedence over saved preferences; saved preferences override inferred habits and generic editorial defaults. Preferences cannot expand authorization, manufacture evidence, or override platform constraints.

At final review, check the applicable preferences again, including revisions to announcement copy. Do not expose internal preference notes in public copy. Recheck dated factual information when relevant; memory is not proof of current product availability or platform rules. Review experiments when the specified review point arrives and use actual supplied results, not invented analytics.

## Hosts without durable writable storage

Use an existing user-designated persistent document only if tools and authorization support it. Otherwise apply feedback within the conversation and return a compact “Preferences for the next post” block with the same scope and instructions for the user to carry forward. Clearly say that a new session must receive that block. Do not claim cross-session learning, silently create a remote document, or write preferences to a different publication.

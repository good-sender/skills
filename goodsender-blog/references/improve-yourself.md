# Improve yourself — automatic feedback memory

Run this process on every goodsender-blog invocation, including quick samples, narrow edits, and feedback-only requests. The author never needs to say “improve yourself” or ask to remember. This is persistent working guidance, not model retraining or an automatic rewrite of the installed skill.

## Initialize and read before work

Resolve `gs/feedback.md` relative to the directory where the skill was invoked, before changing working directories. Keep that resolved path for the whole task. Create `gs/` and the file if absent, even when there is no feedback yet. If the file exists, read and preserve it; never overwrite it with the skeleton or create a fresh file per post. Do not substitute the installed skill directory or another blog's folder.

Initial contents:

```markdown
# GoodSender author feedback

Author corrections, refinements, suggestions, and improvement remarks captured automatically. Apply entries only within their recorded scope.

## Feedback
```

Do not invent entries just to populate the file. Respect an explicit no-storage request. If the path is occupied by an incompatible file/directory or storage fails, preserve existing content, report the problem, and continue with conversation-local feedback; do not silently relocate the file. Keep feedback local and out of published copy, release bundles, or commits unless the author asks to include it.

Load relevant entries before composing. Use publication, account, platform, post type, and post-specific scope to select them. When the folder serves multiple publications, identify the publication on each entry and keep them separate. Do not apply an entry with unclear publication identity across blogs.

## Capture feedback automatically

As the author corrects, refines, or comments on the work, apply the requested edit and update the file without asking whether to remember it. Before finishing each call, check the conversation for feedback not yet captured. Store useful remarks and improvement thoughts from the author, not every conversational turn or the assistant's own speculative preferences.

Classify each entry so future work uses it appropriately:

- **Preference:** a reusable instruction or clearly general refinement, such as “Your LinkedIn openings are too vague; start with the practical takeaway.” Apply it to later matching work without requiring the word “always.”
- **Post correction:** a specific change, such as “Remove this hashtag from this announcement.” Record the post/context and correction; use it when revisiting that post. Do not infer a permanent hashtag ban.
- **Suggestion/experiment:** tentative advice, such as “Maybe try a question next time.” Retain it as tentative and consider it for matching future work; do not convert it into a mandatory rule or proven performance claim.

If scope is unclear, capture the remark with its original context and narrowest supported scope. Do not interrupt work just to authorize storage. Ask only when ambiguity prevents the actual requested edit or a consequential future choice. Preserve actual factual corrections with their date and author provenance; memory is not independent verification of those facts.

Example entry:

```markdown
### FB-001 — Concrete LinkedIn openings
- Date: 2026-10-15
- Kind: preference
- Status: active
- Scope: this publication / LinkedIn announcements
- Author feedback: “Your LinkedIn openings are too vague; start with the practical takeaway.”
- Apply: Lead with the article's concrete practical takeaway before introducing the article.
- Context: Review of the release-checklist announcement.
- Replaces: none
```

Use the actual date and known publication identity, a short quote or faithful paraphrase, and the minimum context needed. Do not retain secrets or unnecessary private details. Keep the author feedback distinguishable from the assistant's distilled application guidance. Store feedback canonically here; if a correction also updates `facts.md`, `visual.md`, or `blog.md`, keep those files consistent and reference the feedback entry rather than creating competing rules.

Merge duplicates while retaining meaningful context. A newer general correction supersedes an older conflicting preference in the same scope: mark the old entry superseded and link the replacement. A one-post override leaves the standing preference active for the next post. On a request to forget an entry, remove it and any corresponding retained preference in workspace files; do not promise deletion from prior chats or backups.

Re-read after writes to verify persistence. Briefly mention file creation or meaningful saved changes in the normal update/handoff; do not ask for confirmation or recite the entire log on every call. If nothing new was said, leave the existing file unchanged after reading it.

## Apply on subsequent calls and final review

Current explicit instructions take precedence over saved feedback. Applicable active preferences override inferred habits and generic editorial defaults. Suggestions inform choices without becoming requirements. Post corrections apply only to their recorded context. Superseded entries are history, not active instructions. Feedback does not expand publication authorization, create evidence, or override platform constraints.

Include applicable guidance in the brief when one is being created. At final review, check the requested artifacts against it, including revised announcements, and capture any new author remarks. Recheck time-sensitive factual information rather than assuming a saved correction is still current. Evaluate experiments only from actual supplied or retrieved results.

## Hosts without durable writable storage

If no filesystem is available, say that `gs/feedback.md` could not be created. Apply feedback in the conversation and provide a compact portable feedback block for the next session. An existing user-designated persistent document can be used when supported and authorized, but do not silently create a remote document or claim cross-session memory without verified durable storage.

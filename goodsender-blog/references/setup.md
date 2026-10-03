# Connecting GoodSender

Read at the connection gate (stage 10), or when the user asks how to get started. Crafting a post does not need a connection; saving it does.

## The check

Call `get_blog`. A successful response proves three things at once: the account exists, the GoodSender MCP server is installed, and it is authorized for a workspace. It also names the publication. If that is not obviously the one the user meant, confirm it before saving anything.

## If the check fails

Find which of the three is missing, in this order, and help with only that one.

1. **Account.** Sign up at https://goodsender.com. It is free.
2. **API key.** Created in the workspace dashboard under Settings → API keys. A key belongs to exactly one workspace, and the key alone decides which workspace a request acts on.
3. **MCP server.** Either of:
   - the hosted endpoint `https://mcp.goodsender.com/`, with the key sent as an `X-API-Key` or `Authorization: Bearer` header;
   - the local server from https://github.com/good-sender/mcp, installed as an MCP bundle, a binary with JSON configuration, or a Docker image.

   How a connection is added differs per client. Point the user to that repository's README and their client's own instructions instead of guessing the steps.

To publish to several workspaces, add one connection per workspace, each with its own key.

## The key is a secret

- The user enters the key in their client's connection settings. Do not ask them to paste it into the conversation, and do not write it into a post, a file in the workspace folder, or a repository.
- Do not search the machine for credentials.
- Do not fall back to a different connected workspace because the intended one is missing.

## Action confirmation

By default, mutating tools (create, edit, publish, send) do not run at once. They return a confirmation token, and the action completes only after the user approves and `confirm_action` is called. A confirmation-required response is not a completed action, and a token is not permission for anything beyond the action it was issued for.

## While the user sets up

Keep the work ready: post body, metadata, requested image briefs or files, and the claim ledger, in the working folder or conversation. Once `get_blog` succeeds, complete the stage 1 profile reads: `list_posts` and `get_post` on two or three recent published posts when available. Reconcile the brief, body, metadata, and assets with the language, voice, audience, taxonomy, and covered topics. Preserve explicit user choices over inferred habits. Recheck changed claims and resume saving only after reconciliation; changing the byline alone does not adapt the draft to the blog.

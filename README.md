# GoodSender Skills

Agent Skills for working with [GoodSender](https://goodsender.com): publishing on your own domain, newsletter distribution, and consent-based email. Each skill conforms to the [Agent Skills specification](https://agentskills.io/specification) and works across agent platforms that support skills (Claude Code, Codex, Copilot CLI, Gemini CLI, and others).

## Install

Each skill is a ready-made ZIP. The links below always point at the latest version.

| Skill | Use it when you want to… | Download |
|-------|--------------------------|----------|
| [`goodsender-publish`](goodsender-publish/) | Prepare a blog post, cover, useful inline visuals, social announcements, and newsletter copy around a publishing goal; review the draft or publish to authorized destinations through connected GoodSender MCP tools. | [**goodsender-publish-latest.zip**](https://github.com/good-sender/skills/releases/latest/download/goodsender-publish-latest.zip) |
| [`goodsender-api-integration`](goodsender-api-integration/) | Integrate the GoodSender HTTP API into your own app or service — get an API key, verify a sending domain, request recipient consent, and send general or transactional email. | [**goodsender-api-integration-latest.zip**](https://github.com/good-sender/skills/releases/latest/download/goodsender-api-integration-latest.zip) |

### Claude (desktop app or claude.ai)

1. Click the **Download** link for the skill you want.
2. In Claude, open **Customize > Skills > Create skill > Upload a skill**.
3. Upload the ZIP as downloaded — no need to unpack it.

Skills must be enabled for your account; see [Use skills in Claude](https://support.claude.com/en/articles/12512180-use-skills-in-claude). To update a skill later, download the link again and re-upload.

### Claude Code and other agents

Unpack the ZIP into your agent's skills folder:

```bash
curl -L -o goodsender-publish.zip https://github.com/good-sender/skills/releases/latest/download/goodsender-publish-latest.zip

unzip goodsender-publish.zip -d ~/.claude/skills/    # Claude Code, all projects
unzip goodsender-publish.zip -d .claude/skills/      # Claude Code, this project only
```

Other platforms use their own skills directory (e.g. `~/.agents/skills/` for Codex) — unpack there instead. Keep the directory name identical to the skill's `name` field.

### Connecting GoodSender for `goodsender-publish`

Installing a skill does not connect an account or select a workspace. Connect GoodSender in your agent separately, using your own workspace's authentication; the hosted MCP endpoint is `https://mcp.goodsender.com/`. Image generation is optional and depends on your agent's available tools.

Example request:

> Use goodsender-publish to prepare a post explaining our new feature to existing users. Use the attached release notes and screenshots, prepare LinkedIn and newsletter copy, and leave everything as a draft for review.

The skill establishes the intended reader and outcome, uses the blog's existing byline and taxonomy, prepares assets and destination copy, and returns a preview. It also supports immediate publication when explicitly requested for the specified destinations. dev.to and Hashnode receive the original article; announcements and newsletter text are adapted separately. A simple sample draft or a narrow edit stays small.

## Versions and releases

Each skill carries its own version in `SKILL.md` frontmatter (`metadata.version`, `MAJOR.MINOR.PATCH`). Whenever a skill folder changes on `main`, CI publishes a new [release](https://github.com/good-sender/skills/releases) with two ZIPs per skill:

- `<skill>-latest.zip` — what the links above download; always the newest version.
- `<skill>-<version>.zip` — the same package under its version number, for pinning. Older versions stay available on their release pages.

## What is a skill?

A skill is a directory containing a `SKILL.md` file (YAML frontmatter + Markdown instructions) and optional supporting files under `references/`, `scripts/`, or `assets/`. Agents load the `name` and `description` at startup and pull in the full body only when the skill is relevant. See the [specification](https://agentskills.io/specification) for details.

## Repository layout

```
skills/
├── README.md
├── CONTRIBUTING.md
├── LICENSE
└── <skill-name>/
    ├── SKILL.md          # required: frontmatter (incl. metadata.version) + instructions
    └── references/       # optional: detailed reference docs
```

## Validation

Skills are checked against the spec with [`skills-ref`](https://github.com/agentskills/agentskills/tree/main/skills-ref). CI runs it on every push and pull request; to run it locally:

```bash
pip install "git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref"
skills-ref validate ./goodsender-api-integration
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[Apache-2.0](LICENSE). See [NOTICE](NOTICE) for attribution.

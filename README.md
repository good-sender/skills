# GoodSender Skills

Agent Skills for working with [GoodSender](https://goodsender.com): publishing on your own domain, newsletter distribution, and consent-based email. Each skill conforms to the [Agent Skills specification](https://agentskills.io/specification) and works across agent platforms that support skills (Claude Code, Codex, Copilot CLI, Gemini CLI, and others).

## Available skills

| Skill | Use it when you want to… |
|-------|--------------------------|
| [`goodsender-api-integration`](goodsender-api-integration/) | Integrate the GoodSender HTTP API into your own app or service — get an API key, verify a sending domain, request recipient consent, and send general or transactional email. |
| [`goodsender-publish`](goodsender-publish/) | Prepare a blog post, cover, useful inline visuals, social announcements, and newsletter copy around a publishing goal; review the draft or publish to authorized destinations through connected GoodSender MCP tools. |

## What is a skill?

A skill is a directory containing a `SKILL.md` file (YAML frontmatter + Markdown instructions) and optional supporting files under `references/`, `scripts/`, or `assets/`. Agents load the `name` and `description` at startup and pull in the full body only when the skill is relevant. See the [specification](https://agentskills.io/specification) for details.

## Installing a skill

Copy the skill directory into your agent's skills folder. For example, with `goodsender-api-integration`:

```bash
# Project-scoped (Claude Code)
mkdir -p .claude/skills
cp -R goodsender-api-integration .claude/skills/

# User-scoped (Claude Code)
cp -R goodsender-api-integration ~/.claude/skills/
```

Other platforms use their own skills directory (e.g. `~/.agents/skills/` for Codex) — place the directory there instead. Keep the directory name identical to the skill's `name` field.

### Publishing with GoodSender

Install `goodsender-publish` the same way. Connect GoodSender in your agent first, using your own workspace's authentication. The hosted MCP endpoint is `https://mcp.goodsender.com/`; installing a skill does not connect an account or select a workspace. Image generation is optional and depends on your agent's available tools.

Example request:

> Use goodsender-publish to prepare a post explaining our new feature to existing users. Use the attached release notes and screenshots, prepare LinkedIn and newsletter copy, and leave everything as a draft for review.

The skill establishes the intended reader and outcome, uses the blog's existing byline and taxonomy, prepares assets and destination copy, and returns a preview. It also supports immediate publication when explicitly requested for the specified destinations. dev.to and Hashnode receive the original article; announcements and newsletter text are adapted separately. A simple sample draft or a narrow edit stays small.

For Claude's skill upload interface, package only the skill folder, with `goodsender-publish/SKILL.md` inside the ZIP:

```bash
zip -r goodsender-publish.zip goodsender-publish
```

Upload that ZIP through **Customize > Skills > Create skill > Upload a skill**. See the [Claude skill installation instructions](https://support.claude.com/en/articles/12512180-use-skills-in-claude). The GoodSender connection is configured separately.

## Repository layout

```
skills/
├── README.md
├── CONTRIBUTING.md
├── LICENSE
└── <skill-name>/
    ├── SKILL.md          # required: frontmatter + instructions
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

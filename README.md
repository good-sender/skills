# GoodSender Skills

Agent Skills for working with [GoodSender](https://goodsender.com) — the free, consent-based email service. Each skill conforms to the [Agent Skills specification](https://agentskills.io/specification) and works across agent platforms that support skills (Claude Code, Codex, Copilot CLI, Gemini CLI, and others).

## Available skills

| Skill | Use it when you want to… |
|-------|--------------------------|
| [`goodsender-api-integration`](goodsender-api-integration/) | Integrate the GoodSender HTTP API into your own app or service — get an API key, verify a sending domain, request recipient consent, and send general or transactional email. |

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

[MIT](LICENSE).

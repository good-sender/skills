# Contributing

Thanks for contributing a GoodSender skill. Skills in this repo must conform to the [Agent Skills specification](https://agentskills.io/specification).

## Rules

- **One skill per top-level directory.** The directory name must exactly match the skill's `name` frontmatter field.
- **`name`**: 1–64 chars, lowercase letters/numbers/hyphens only, no leading/trailing or consecutive hyphens.
- **`description`**: 1–1024 chars, non-empty, says *what* the skill does and *when* to use it.
- **Body**: keep `SKILL.md` focused (under ~500 lines). Move long reference material into `references/` and link to it with relative paths one level deep.
- **Optional dirs**: use `references/` for docs, `scripts/` for runnable code, `assets/` for static resources.
- **Don't fabricate.** Every concrete claim (endpoints, fields, limits) must be sourced from the GoodSender API/spec, not assumed.

## Before opening a PR

1. Validate locally:

   ```bash
   pip install "git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref"
   skills-ref validate ./<skill-name>
   ```

2. Add your skill to the table in [README.md](README.md).
3. CI must pass — it runs `skills-ref validate` on every skill directory.

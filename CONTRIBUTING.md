# Contributing to Pantheon

Thank you for considering a contribution to Pantheon.

Pantheon is a lightweight agentic development framework. Most contributions are changes to Markdown instructions, command prompts, schemas, installer scripts, or small utility scripts. Keep changes focused and easy to audit.

## Contribution Guidelines

- Preserve strict agent role boundaries.
- Keep the core framework self-contained.
- Avoid adding runtime dependencies unless the reason is explicit and unavoidable.
- Update documentation when command behavior, workflow order, file paths, or agent responsibilities change.
- Keep safety rules conservative around command execution, secrets, and file modification scope.
- Prefer small pull requests with one clear purpose.

## Local Checks

Before submitting a change, run the checks that apply to your environment:

```bash
claude plugin validate .
```

If you have access to the Codex plugin validator:

```bash
python3 /path/to/validate_plugin.py /path/to/Panteon
```

For documentation changes, also review:

- `README.md`
- `docs/GUIDE.md`
- `docs/SECURITY.md`
- `skills/GLOBAL_RULES.md`
- `.claude-plugin/plugin.json`
- `.codex-plugin/plugin.json`

Make sure they do not contradict each other.

## Security

Do not include secrets, credentials, private keys, production tokens, or sensitive customer data in issues, pull requests, examples, or tests.

If you find a security issue, report it privately to the maintainer before opening a public issue.

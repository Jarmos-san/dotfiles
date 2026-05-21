# AGENTS.md — Jarmos's Dotfiles

Personal dotfiles for Linux/macOS development environment. **Not a reusable product** — reference only.

## Verification (run in order)

```bash
pre-commit run --all-files   # run everything: lint, format, typecheck, commit-msg lint
```

Individual checks (all run in CI on push):
- `stylua . --check` — Lua formatting
- `selene .` — Lua linting (std=`vim` via `selene.toml`)
- `ruff check "$PWD"` — Python lint
- `black . --check` — Python formatting
- `mypy .` — Python type checking
- `shfmt --indent=2 --case-indent --binary-next-line --space-redirects --keep-padding <file>` — shell formatting

## Style

EditorConfig is the source of truth (`.editorconfig`):
- Lua: 2-space indent
- Python: 4-space indent
- JSON/MD/TOML/YAML: 2-space indent
- Shell: 2-space indent
- All: LF, UTF-8, trim trailing whitespace, final newline

## Structure

- `dotfiles/` — config source (symlinked to `$HOME` by `bootstrap.sh`)
- `dotfiles/.config/` — app configs (nvim, fish, git, tmux, wezterm, bat, gh, glow, pip, flameshot)
- `dotfiles/.local/bin/update` — Python utility for system updates (apt/dnf + brew)
- `dotfiles/.homebrew/linux.Brewfile` — Homebrew packages for Linux
- `bootstrap.sh` — NOT production-ready (hardcoded `jarmos` user, FIXMEs, untested)

## Python

Uses `uv` for virtual environments. `ruff` for both lint and format (via `--fix`). pip configured with `require-virtualenv=true`.

## Neovim

Heavy Lua config under `dotfiles/.config/nvim/` using `lazy.nvim`. LSP for many languages.

## Shell

Fish is the default interactive shell (set in Wezterm and `chsh`). Fish config under `dotfiles/.config/fish/` with custom prompt, greeting, abbreviations, and functions.

## CI

Four parallel jobs on push: stylua → check, selene → lint, ruff → lint, black → check.

# Environment variables managed via conf.d for reproducibility.
# Previously stored in fish_variables (universal), moved here
# so they are version-controlled and consistent across machines.

set --global --export HOMEBREW_NO_AUTO_UPDATE 1
set --global --export HOMEBREW_NO_ENV_HINTS 1
set --global --export PNPM_HOME "$HOME/.local/share/pnpm"
set --global --export VIRTUAL_ENV_DISABLE_PROMPT 1

set --global --export PATH \
    "$HOME/.local/share/pnpm" \
    "$HOME/.local/bin" \
    "/home/linuxbrew/.linuxbrew/bin" \
    $PATH

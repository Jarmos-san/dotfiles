if status is-interactive
    # Enable rendering of Git repository state markers.
    set --global __fish_git_prompt_showdirtystate 1
    set --global __fish_git_prompt_showuntrackedfiles 1
    set --global __fish_git_prompt_showstashstate 1
    set --global __fish_git_prompt_showupstream 1

    # All non-clean Git states are rendered in red to signal attention.
    set --global __fish_git_prompt_color_dirtystate cc241d
    set --global __fish_git_prompt_color_untrackedfiles cc241d
    set --global __fish_git_prompt_color_stagedstate cc241d
    set --global __fish_git_prompt_color_stashstate cc241d
    set --global __fish_git_prompt_color_upstream cc241d
    set --global __fish_git_prompt_color_upstream cc241d

    # Custom symbols used to represent Git repository state.
    # Some states intentionally share the same glyph to reduce visual noise.
    set --global __fish_git_prompt_char_dirtystate '[]'
    set --global __fish_git_prompt_char_untrackedfiles '[]'
    set --global __fish_git_prompt_char_stagedstate '[]'
    set --global __fish_git_prompt_char_stashstate '[󰇁]'

    # Indicate divergence from the tracked upstream branch.
    set --global __fish_git_prompt_char_upstream_ahead '[󱦲]'
    set --global __fish_git_prompt_char_upstream_behind '[󱦳]'

    # Suppress the "=" marker when in sync with upstream
    set --global __fish_git_prompt_char_upstream_equal ''
end

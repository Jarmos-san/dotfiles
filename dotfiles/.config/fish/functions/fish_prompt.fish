# Customise the interactive prompt for the shell
function fish_prompt
    # Store the exit code of the last command which executed
    set --local last_status $status

    # Local variable to store and format the exit code in the prompt
    set --local stat

    # The second line of the prompt responsible for receiving user activity
    set --local arrow (set_color 8ec07c)"-> "(set_color normal)

    # Local variable to the Git branch information of the local repository
    set --local git_branch

    # Single empty line to act as a separator for the interactive shell prompt
    printf "\n"

    # Modify the 1st line of the prompt and the 2nd line based on the exit code
    # of the last executed command. The 1st line displays the exit code at the
    # end if it is non-zero number and the arrow on the 2nd line is rendered in
    # red. If the status code is 0 then nothing is rendered at the end and the
    # arrow on the 2nd line is green
    if test $last_status -ne 0
        set stat (set_color fb4934)"[$last_status]"(set_color normal)
        set arrow (set_color fb4934)"-> "(set_color normal)
    end

    # Default: user-friendly path (~, shortening, etc.) by default it renders
    # the full length of the directory or file path
    set --local display_pwd (prompt_pwd --dir-length=0)

    # Logic to customise the prompt according to the Git context of the current
    # working directory
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # Create the local Git branch segment of the 1st line
        set git_branch (set_color d3869b)(__fish_git_prompt ' %s')(set_color normal)

        # Create the root truncated path for local Git repositories
        set --local git_root (command git rev-parse --show-toplevel)
        set --local repo_name (basename $git_root)
        set --local rel_path (string replace -r "^$git_root/?" '' -- $PWD)

        # Create a full path inside the local Git repository
        if test -n "$rel_path"
            set display_pwd "$repo_name/$rel_path"
        else
            set display_pwd "$repo_name"
        end

        # Set the prompt display in accordance to the local Git repository
        set_color fbf1c7
        printf '%s on %s %s\n' $display_pwd $git_branch $stat
        set_color normal
    else
        # Set the prompt display if the current working directory is not a
        # local Git repository
        set_color fbf1c7
        printf '%s %s\n' $display_pwd $stat
        set_color normal
    end

    # Render the arrow on the 2nd line which accepts the user inputs
    printf '%s' $arrow
end

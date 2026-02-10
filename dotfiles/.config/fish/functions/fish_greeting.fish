function fish_greeting
    # Subset of all the colours from the OG gruvbox theme
    set --local gray 928374
    set --local fg ebdbb2
    set --local green b8bb26
    set --local yellow fabd2f

    # List of zen quotes to display randomly on login
    set --local messages \
        "When you realise nothing is lacking, the whole world belongs to you." \
        "I live by letting things happen." \
        "Wise men don't judge - they seek to understand." \
        "Life is a balance of holding on and letting go." \
        "Let go, or be dragged." \
        "One loses joy and happiness in the attempt to posses them." \
        "Before enlightenment; chop wood, carry water. After enlightenment; chop wood, carry water." \
        "The less you try to impress, the more peaceful you can be." \
        "The ability to observe without evaluation is the highest form of intelligence." \
        "Do not think you will necessarily be aware of your enlightenment."

    # Warning message when logged in as a root user
    set --local warning (set_color $yellow)(string join "" -- "WARNING: You're logged in as root")(set_color normal)

    # The welcome message on the first line
    set --local msg (set_color $gray)(string join "" -- "Welcome back, Jarmos!")

    # The time of the day in Indian Standard Time (IST)
    set --local time (set_color $fg)(date "+%H:%M")(set_color $gray)

    # The hostname of the current system
    set --local host (set_color $green)(string join "" -- $hostname)

    # The random quote
    set --local quote (set_color $gray)(string join "" -- (random choice $messages))(set_color normal)

    # Render the welcome message on logic
    if test (id -u) -eq 0
        printf "\n%s\n\n" $warning
    else
        printf "\n%s\n\n" $msg
        printf "time\t%s IST\n" $time
        printf "host\t"
        printf "%s\n\n" $host
        printf "%s\n" $quote
    end
end

function mkc --description "Create a directory and cd into it"
    if set -q argv[1]
        mkdir --parents $argv[1]
        cd $argv[1]
    else
        echo "usage: mkc <name>"
    end
end

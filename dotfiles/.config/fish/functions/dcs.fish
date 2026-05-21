function dcs --description "Stop and remove a running Docker container"
    if set -q argv[1]
        docker container stop $argv[1]
        docker container remove $argv[1] --volumes
    else
        echo "usage: dcs <docker-container-name>"
    end
end

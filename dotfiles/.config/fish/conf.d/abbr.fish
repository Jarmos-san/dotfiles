# An abbreviation for listing the contents of the current directory using "eza"
abbr --add ll "eza --long --all --classify --icons --git --ignore-glob='.git|.mypy_cache|.venv|__pycache__|.coverage|.pytest_cache|.ruff_cache|.task'"

# Print the directory tree of the contents of a directory
abbr --add tree "eza --tree --all --icons --ignore-glob='.git|.mypy_cache|.terraform.lock.hcl|.gitkeep' --git-ignore"

# Print the lines of code of a file
abbr --add loc "wc --lines"

# Tmux abbreviations
abbr --add dots "tmux new-session -c ~/.dotfiles"
abbr --add tnew "tmux new-session"
abbr --add arthika "tmux new-session -c ~/projects/arthika"
abbr --add tls "tmux list-session"
abbr --add tks "tmux kill-server"
abbr --add homelab "tmux new-session -s homelab -n homelab -c ~/projects/homelab"

# Golang development abbreviations
abbr --add gotest "gotestsum --format testdox"
abbr --add golint "golangci-lint run ./..."
abbr --add gofmt "golangci-lint fmt ./..."
abbr --add goimports "goimports-reviser -use-cache -rm-unused -set-alias"

# Docker abbreviations
abbr --add compose "docker compose"
abbr --add dcup "docker compose up --detach"
abbr --add dcdown "docker compose down --remove-orphans --volumes"
abbr --add dclogs "docker compose logs"
abbr --add dps "docker ps --format 'table {{ .ID }}\t{{ .Names }}\t{{ .Ports }}'"
abbr --add dims "docker images"
abbr --add dimc "docker image prune --force"
abbr --add drmi "docker image rm"

# Terraform abbreviations
abbr --add tfinit "terraform init"
abbr --add tfval "terraform validate"
abbr --add tfplan "terraform plan"

# Database abbreviations
abbr --add pgdb "docker run --detach --name postgresql --rm -p 5432:5432 -e POSTGRESQL_USERNAME=psqladmin -e POSTGRESQL_PASSWORD=admin -e POSTGRESQL_DATABASE=postgres bitnami/postgresql:16"
abbr --add rsdb "docker run --name redis --rm -p 6379:6379 -e ALLOW_EMPTY_PASSWORD=yes bitnami/redis:7.2"

# NPM abbreviations
abbr --add npm pnpm
abbr --add npx "pnpm dlx"

# Python abbreviations
abbr --add mkvenv "uv venv"
abbr --add py python3

# General abbreviations
abbr --add top "btop --utf-force"
abbr --add cm "cmatrix -abs"
abbr --add rands "openssl rand -base64 32"
abbr --add dateiso "date +%Y-%m-%dT%H:%M:%S%z"
abbr --add ct cookiecutter
abbr --add webp cwebp
abbr --add blogs "cd ~/projects/blogposts"
abbr --add pcs "pre-commit sample-config >> .pre-commit-config.yaml && pre-commit autoupdate &>/dev/null"
abbr --add git-sync "git switch main && git fetch --prune && git branch -vv | awk '/: gone/ {print $1}' | xargs -r git branch --delete"
abbr --add glow "glow --style ~/.config/glow/styles/gruvbox-dark.json"

# OpenCode abbreviations
abbr --add oc opencode

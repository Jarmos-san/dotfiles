function update --wraps='sudo apt-get update && sudo apt-get upgrade -y; brew update && brew upgrade && brew autoremove' --description 'alias update=sudo apt-get update && sudo apt-get upgrade -y; brew update && brew upgrade && brew autoremove'
  sudo apt-get update && sudo apt-get upgrade -y; brew update && brew upgrade && brew autoremove $argv;
end

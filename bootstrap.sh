#!/usr/bin/env bash

###############################################################################
# Script to automatically setup a fresh new Linux/MacOS system (or VM).
#
# This script should ONLY be used after installing a fresh new OS on a new
# machine or inside a VM to setup a development environment automatically. The
# script will install necessary tools like code editors, package managers and
# more before setting up their configuration files automatically.
#
# USAGE: To use the script, run the following command (its not ready for usage yet);
#
# curl -fsSL https://raw.githubusercontent.com/<username>/<repository>/path/to/script \
#   | bash -s
#
# NOTE: The script is designed to be subjective, hence it is RECOMMENDED to NOT
# invoke it without understanding the context of the contents! Please read
# through the script or reach out to the author for clarification on what
# certain parts of the script does.
#
# DISCLAIMER: The script IS NOT TESTED and there is no guranteed it works
# properly!
#
# Author: Somraj Saha <somraj.saha@jarmos.dev>
# License: MIT (see the LICENSE document for more info on this regards)
###############################################################################

# Enable some options for Bash to stop executing the script if there's an error
set -o errexit
set -o nounset
set -o pipefail

# Enable debugging capabilities to the script
if [[ "${TRACE-0}" == "1" ]]; then
  set -o xtrace
fi

# Logic to print out a simple help message to STDOUT
if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
  echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
  exit
fi

# Execute the script in context to the current directory where the script is run
cd "$(dirname "$0")"

###############################################################################
# Print a nicely formatted informative message to STDOUT
###############################################################################
info() {
  echo -e "\033[0;34m[INFO]\033[0m $1"
}

###############################################################################
# Print a nicely formatted warning message to STDOUT
###############################################################################
warn() {
  echo -e "\033[0;33m[WARN]\033[0m $1"
}

###############################################################################
# Print a nicely formatted success message to STDOUT
###############################################################################
success() {
  echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

###############################################################################
# Print a nicely formatted error message to STDOUT
###############################################################################
error() {
  echo -e "\033[0;31m[ERROR]\033[0m $1"
}

###############################################################################
# Update the system before starting the automated setup
###############################################################################
update_system() {
  info "Updating the system before starting the automated setup..."

  # TODO: Uncomment the following line post completion
  # apt-get upgrade && apt-get upgrade --yes
}

###############################################################################
# Install some necessary prerequisite tools before the setup script runs
###############################################################################
install_prerequisites() {
  # List of prerequisite tools to check for existence
  declare -a prerequisite_tools

  # List of prerequisite tools which aren't installed and will be eventually!
  declare -a missing_tools

  prerequisite_tools=("git" "curl" "gcc")

  # Check for missing prerequisite tools and store them for future reference
  for tool in "${prerequisite_tools[@]}"; do
    if ! command -v "${tool}" &>/dev/null; then
      missing_tools+=("$tool")
    else
      missing_tools=()
    fi
  done

  if [[ ${#missing_tools[@]} -ne 0 ]]; then
    warn "These tools were not found & hence will be installed!"

    for tool in "${missing_tools[@]}"; do
      echo "    $tool"
    done

    # TODO: Uncomment this line post-completion
    # apt-get install --yes --no-install-recommends "${missing_tools[@]}"

    info "Prerequisite tools installed...proceeding with automated setup"
  fi
}

###############################################################################
# The entrypoint of the script which will run the script as per the prescribed
# logic
###############################################################################
main() {
  warn "The script will perform an automated setup of the system and can cause\
  potential harm to the system!"

  read -rp "Do you still want to proceed? (yes/no) " yn

  case $yn in
    yes) info "This system will now be automatically setup..." ;;
    no)
      info "Aborting automated system updated..."
      exit 0
      ;;
    *)
      error "Invalid response"
      exit 1
      ;;
  esac

  # Perform a preliminary system update before starting the automated setup
  update_system

  # Install prerequisite tools before the automated setup
  install_prerequisites
}

# Defer running the script till the last moment for safety reasons
main "$@"

#!/usr/bin/env bash

# This file doesn't require anything more than the following contents!
if [ -f "$HOME/.bashrc" ]; then
    # shellcheck disable=1091
    source "$HOME/.bashrc"
fi
. "$HOME/.cargo/env"

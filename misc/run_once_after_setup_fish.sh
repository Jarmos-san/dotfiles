#!/usr/bin/env bash

echo -e "Setting up Fish Shell as the default...\n"

which fish | tee -a /etc/shells

chsh -s "$(which fish)"

# Jarmos's Dotfiles

![GitHub repo size](https://img.shields.io/github/repo-size/Jarmos-san/dotfiles?label=Repo%20Size&logo=GitHub&style=flat-square) ![GitHub](https://img.shields.io/github/license/Jarmos-san/dotfiles?label=License&logo=GitHub&style=flat-square) ![Twitter Follow](https://img.shields.io/twitter/follow/Jarmosan?style=social)

This repository contains various "_dotfiles_" & other configuration files for my personal development needs. Following are a list of software I use regularly for all of my dev needs;

- [Git](https://git-scm.com) (a version-controlled software to be used in tandem with GitHub0
- [Neovim](https://neovim.io) (a terminal-based Text Editor)
- [GNU Privacy Guard](https://gnupg.org) (`gpg` for signing `git` commits)
- [VSCode](https://code.visualstudio.com) (an optional GUI-based Text Editor for the rare times when Neovim isn't enough)
- [Bat](https://github.com/sharkdp/bat) (a drop-in replacement for `cat`)
  - [batman](https://github.com/eth-p/bat-extras/blob/master/doc/batman.md)
  - [batdiff](https://github.com/eth-p/bat-extras/blob/master/doc/batdiff.md)
  - [prettybat](https://github.com/eth-p/bat-extras/blob/master/doc/prettybat.md)
- [Glow](https://github.com/charmbracelet/glow) (a Markdown previewer for the TUI)
- [Starship](https://starship.rs) (a fast & customizable prompt)
- [Homebrew](https://brew.sh/) (an alternative & better package manager for Linux & MacOS)
- [GitHub CLI](https://cli.github.com) (a CLI tool to manage GitHub from the terminal)
- [Hugo](https://gohugo.io) (a Static Site Generator used for my personal blog)
- [GNU Compiler Collection](https://gcc.gnu.org) (`gcc` required for compiling Treesitter parsers for `nvim-treesitter` plugin)
- [Python v3.x](https://www.python.org)
- [Poetry](https://python-poetry.org) (a modern packaging tool for Python)
- [NodeJS](https://nodejs.org) (a programming language runtime which a lot of frontend libraries & frameworks depend on)
- [GNU Stow](https://www.gnu.org/software/stow) (yet another CLI tool to manage my dotfiles & configurations)

Do note, the list of configuration is never-ending & is subject to change over time. It's **recommended** to not use the config files as is but take inspiration from & configure your own workflow.

For those of you who work from on Windows machine through some Windows Subsystem for Linux (WSL) instance, you should checkout my [dotfiles-windows](https://github.com/Jarmos-san/dotfiles-windows) repository. That repository contains more information on how to setup a Linux development environment on Windows 10 (and Windows 11 when it's available publicly).

## Caveats

Following are some of caveats to take notice of while using these dotfiles:

1. On WSL, Debian comes with a very minimal set of installed packages. And surprisingly, it doesn't include `wget` or `curl` either! So, it's advisable to install either one of them before using the dotfiles here. `wget` can be installed by running the `sudo apt install wget -y` command.

2. Each WSL distro can be configured individually. These configurations are specific to a WSL environment & won't work on native Linux environments. For more info on the topic, refer to the [official Microsoft WSL docs](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configure-settings-with-wslconfig-and-wslconf). Besides, here's an [example `wsl.conf` file](https://raw.githubusercontent.com/Jarmos-san/dotfiles-windows/master/configs/wsl/wsl.conf) which should placed under `/etc`.

3. If using Debian, by default most third-party packages other than core updates can be installed. Hence, it's important to update the `/etc/apt/sources.list` file with necessary info. A detailed writeup on the same is available in [this article](https://www.tecmint.com/fix-unable-to-locate-package-error-in-debian-9/).

...more such caveats will be noted as & when I come across any.

## How to Use This Project

TODO: Detail steps to use the configurations

### Setting Up `git` Version Control System

While the "bootstrap" script takes care of automating most of the configuration
setup, setting up `git` still requires some manual effort. Following are a few
steps you might've to after executing the "bootstrap" script.

1. Append the following environment variables to the `~/.exports` file.
	
	```console
	GIT_AUTHOR_NAME="your-name"
	GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
	GIT_AUTHOR_EMAIL="you-email-address"
	GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
	```
2. Run the following commands after setting up those environment variables.

	```console
	git config --global user.name "$GIT_AUTHOR_NAME"
	git config --global user.email "$GIT_AUTHOR_EMAIL"
	```

3. Add GPG keys to GitHub. Follow the [official guide](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-new-gpg-key-to-your-github-account) to set it up by yourself.

## Acknowledgements

The configurations I used are heavily inspired from other giants of the community. Following are some of the repositories I keep an eye out for inspiration.

- Salomon Popp's [disrupted/dotfiles](https://github.com/disrupted/dotfiles)
- Mathias Bynen's [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [codeinthehouse's gist](https://gist.githubusercontent.com/codeinthehole/26b37efa67041e1307db/raw/67c06401c3cdb7f7f96aa9054e95cbe0e473b7f0/osx_bootstrap.sh)
- Dries Vints's [driesvints/dotfiles](https://github.com/driesvints/dotfiles)

More will be added as & when I come across any.

## Support the Project

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/jarmos)

If you found any of the dotfiles here helpful for your requirements in any way, consider supporting the project. And here's how you can do so:

- Contribute to documenting the project. That way you can ensure my personal dotfiles are accessible to everyone in the community. And you can help out someone who's facing issues configuring their software as well.
- Found some discrepancies here & there? Feel free to send a PR but do read the [contributing guidelines](./.github/CONTRIBUTING.md) thoroughly.
- Send a [token of appreciation](https://ko-fi.com/jarmos) or a [thank you message](https://saythanks.io/to/somraj.1994) stating how my project & resources helped you out.

## Terms & Conditions of Usage

Everything in this repository is licensed under the T&Cs of FOSS license. More specifically, the project is licensed under the T&Cs of GPL-3.0, so for more info on it, refer to the [LICENSE](./LICENSE). So feel free to copy & distribute any of the configurations I shared in this repository.

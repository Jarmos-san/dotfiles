# Dotfiles (supposed) for My Windows Development Environments

This directory holds all the scripts, configurations, among other stuff required to setup my development environment on a Windows environment. The directory as of the latest commit, contains configurations for the following software(s).

- [Windows Terminal](https://github.com/Jarmos-san/dotfiles/tree/master/Windows/Windows%20Terminal) 
- [Neovim](https://github.com/Jarmos-san/dotfiles/tree/master/Windows/nvim)

## Setup Instructions

### Windows Terminal

The new Windows Terminal from Microsoft is highly customizable. To read more about it, check the article - [Customizing the New Windows Terminal: A Minimalist Approach](https:jarmos.netlify.app/customizing-windows-terminal-a-minimalist-approach). To make your Windows Terminal similar to how it's described in the article, copy the contents of [dotfiles/Windows/Windows Terminal/settings.json](https://github.com/Jarmos-san/dotfiles/tree/master/Windows/Windows%20Terminal/settings.json) to `$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocaState\`.

You can find more information about customizing your Windows Terminal in this article - [Enhance Your Console Experience With Windows Terminal](https://adamtheautomator.com/new-windows-terminal).

### Neovim

While it's possible to use the original `vim` on Windows with `gvim` but [Neovim](https://neovim.io) is a much better alternative with it's preconfigured sensible configurations. It's usable pretty much out-of-the-box without any need for configuring.

The configurations for my Neovim is available under this path: [dotfiles/Windows/Neovim/init.vim](https://github.com/Jarmos-san/dotfiles/tree/master/Neovim/init.vim). At it's current condition it's heavily a WIP file which is why it's void of any content. Regardless of it, rest assured, Neovim is **VERY** usable without any configurations out-of-the-box.

As for where to copy the configuration to. You can copy the contents of my `init.vim` under your `$env:LOCALAPPDATA\nvim\init.vim`. Then ensure to reload `nvim` on your preferred terminal.

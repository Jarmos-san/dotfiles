# Jarmos's Dotfiles

[![Automated Quality Control Checks](https://github.com/Jarmos-san/dotfiles/actions/workflows/main.yml/badge.svg)](https://github.com/Jarmos-san/dotfiles/actions/workflows/main.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/Jarmos-san/dotfiles?label=Repo%20Size&logo=GitHub&style=flat-square)
![GitHub](https://img.shields.io/github/license/Jarmos-san/dotfiles?label=License&logo=GitHub&style=flat-square)
![Twitter Follow](https://img.shields.io/twitter/follow/Jarmosan?style=social)

This repository contains various "_dotfiles_" for my personal development needs.
The said dotfiles are mostly configurations for the tools I used to write code
on a day-to-day basis. And a couple of scripts here & there which helps me setup
those tools with much ease.

I use quite a lot of tools for my daily needs. Listing all of the software I use
daily over here isn't only time-consuming but redundant as well! As such I've
been documenting my development workflow in a "book format". And you can read
about the list of software I use at:
"[_List of Tools I Use For My Software Development Needs_](https://dev-workflow.vercel.app/tools-used)"

Do note, the book & the underlying configurations are ever-changing! They keep
changing as per my requirements over time. So, use the resources available in
this repository as a source of inspiration to build & develop your own workflow.

## How to Use This Project

To manage, backup, edit & pretty much anything to do with the dotfiles is done
with [`chezmoi`](https://chezmoi.io). You can refer to Chezmoi's official docs &
my books to understand how I use Chezmoi.

Besides, using Chezmoi, I also maintain a couple of scripts because not
everything can be automated with the aforementioned tool. These scripts takes
care of stuff which Chezmoi can't. The said scripts are often configured to do
things when I've no clue how to make Chezmoi do it instead.

The book goes into more details about the specific drawbacks & hurdles I faced
while setting up a completely automated workflow with Chezmoi. So, definitely
check it out if possible.

That said, the following single LOC will setup a complete dev environment
(ideally that's what I want it to do but I've achieved that level of competency
yet)!

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply Jarmos-san
```

The single LOC above performs a cURL request to download Chezmoi to the local
machine, invoke the downloaded binary & configure the dotfiles! The last
argument passed to the command above is the name of my GitHub account. And you
should replace it with yours if you're using this command.

And for those of who didn't understand the syntax of the command above, I
suggest taking a look at this write-up:
"[_Invoking a Remote Script to STDIN Using Bash_](https://til-jarmos.vercel.app/invoking-remote-script-to-bash)"

## Acknowledgements

The configurations I used are heavily inspired from other giants of the
community. Following are some of the repositories I keep an eye out for
inspiration.

- Salomon Popp's [disrupted/dotfiles](https://github.com/disrupted/dotfiles)
- Mathias Bynen's
  [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [codeinthehouse's gist](https://gist.githubusercontent.com/codeinthehole/26b37efa67041e1307db/raw/67c06401c3cdb7f7f96aa9054e95cbe0e473b7f0/osx_bootstrap.sh)
- Dries Vints's [driesvints/dotfiles](https://github.com/driesvints/dotfiles)
- Tom Payne's [twpayne/dotfiles](https://github.com/twpayne/dotfiles)

More will be added as & when I come across any.

## Resources For Learning to Use This Project

- [The Ultimate Guide to SSH - Setting Up SSH Keys | freeCodeCamp](https://www.freecodecamp.org/news/the-ultimate-guide-to-ssh-setting-up-ssh-keys)
  to learn about setting up SSH on a local machine.

- [Git for Professionals - freeCodeCamp | YouTube](https://youtu.be/Uszj_k0DGsg)
  to learn about using Git as a professional software developer

- [Chezmoi | To Manage Dotfiles Across Many Machines Securely](https://www.chezmoi.io/links/articles-podcasts-and-videos/)

- [Chezmoi | Articles, Podcasts, Videos on Using Chezmoi](https://www.chezmoi.io/links/articles-podcasts-and-videos)

- [Declarative Management of Dotfiles With Nix & Home Manager](https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager)

- [Managing Dotfiles With Nix](https://alexpearce.me/2021/07/managing-dotfiles-with-nix)

- [Tmux GitHub Wikia](https://github.com/tmux/tmux/wiki)

- [The Tao of Tmux](https://leanpub.com/the-tao-of-tmux/read)

- [Making Tmux Pretty & Usable](https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf)

## Support the Project

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/jarmos)

If you found any of the dotfiles here helpful for your requirements in any way,
consider supporting the project. And here's how you can do so:

- Contribute to documenting the project. That way you can ensure my personal
  dotfiles are accessible to everyone in the community. And you can help out
  someone who's facing issues configuring their software as well.
- Found some discrepancies here & there? Feel free to send a PR but do read the
  [contributing guidelines](./.github/CONTRIBUTING.md) thoroughly.
- Send a [token of appreciation](https://ko-fi.com/jarmos) or a
  [thank you message](https://saythanks.io/to/somraj.1994) stating how my
  project & resources helped you out.

## Terms & Conditions of Usage

Everything in this repository is licensed under the T&Cs of FOSS license. More
specifically, the project is licensed under the T&Cs of GPL-3.0, so for more
info on it, refer to the [LICENSE](./LICENSE). So feel free to copy & distribute
any of the configurations I shared in this repository.

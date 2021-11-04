# Contributing to (My) Dotfiles

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing to my collection of
[dotfiles](https://dotfiles.github.io/). They're meant to automate the process
of setting up my personal development machines (**_both Unix &
Windows-based_**).

The scripts are hosted in this current repository on GitHub for backup purpose &
a robust environment for packaging & distribution.

The content in the current file you're reading from are mostly guidelines, not
rules. Use your best judgment to use and/or propose changes to this document in
a [Pull Request](./PULL_REQUEST_TEMPLATE.md).

## Table Of Contents

- [Contributing to (My) Dotfiles](#contributing-to-my-dotfiles)
  - [Table Of Contents](#table-of-contents)
  - [Code of Conduct](#code-of-conduct)
    - [I Don't Want To Read This Whole Thing I Just Have a Question](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)
  - [What should I know before I get started](#what-should-i-know-before-i-get-started)
    - [dotfiles](#dotfiles)
    - [Design Decisions](#design-decisions)
  - [How Can I Contribute](#how-can-i-contribute)
    - [Suggesting Enhancements](#suggesting-enhancements)
      - [Pull Requests](#pull-requests)
  - [Styleguides](#styleguides)
    - [Git Commit Messages](#git-commit-messages)
    - [Shell Styleguide](#shell-styleguide)
    - [Documentation Styleguide](#documentation-styleguide)
  - [Additional Notes](#additional-notes)
    - [Pull Request Labels](#pull-request-labels)
    - [PR Labels](#pr-labels)

## Code of Conduct

This project and everyone participating in it are governed by the
[CODE OF CONDUCT](https://github.com/Jarmos-san/.github/blob/master/CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behaviour to [somraj.mle@gmail.com](mailto:somraj.mle@gmail.com).

### I Don't Want To Read This Whole Thing I Just Have a Question

> **Note:** Please don't file an issue to ask a question. You'll get faster
> results by using the resources below.

The scripts hosted here in the repository works perfectly fine for me & as
expected. If you've some suggestions about writing certain parts of the script
in a better way, I welcome PRs for it.

Besides, if you've questions regarding my dev environment, feel free to tweet to
me at--[@Jarmosan](https://twitter.com/Jarmosan). Or if you want a detailed
explanation, feel free to have a
[discussion](https://github.com/Jarmos-san/dotfiles/discussions) over it.

Or, perhaps you want to something more personal, then head over to
[here](https://github.com/Jarmos-san/Jarmos-san/discussions/categories/q-a) for
a public Q&A session.

With that said, you might've noticed the "_Issues_" tab is disabled. I did so on
purpose since the scripts work perfectly for my use case.

## What should I know before I get started

### dotfiles

"_dotfiles_" refers to this repository which hosts some shell scripts for
setting up automated development environments on my Unix-based & Windows-based
machines.

The scripts downloads & installs the following applications on my system:

1. Python

2. Docker

3. Poetry(Python package management system)

4. zsh

and a few more stuff (check the
[wiki](https://github.com/Jarmos-san/dotfiles/wiki) for a more detailed
explanation)...

It's not an application for you to download right way to use. Doing so can have
unintended actions on your system. So if you do use some of the scripts or
borrow a snippet or two, **know what you're doing**.

I strongly recommend reading through the scripts to learn what each line are
doing. When in doubt, feel free to reach out to me.

### Design Decisions

The idea behind hosting all these scripts under one roof is for easier packaging
& distribution besides backup availability. The fact that one can set up a
full-blown dev environment on their Ubuntu machine with a call of just a `wget`
invocation or even a `git` clone makes hosting dotfiles in a remote repository
very favourable.

## How Can I Contribute

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for the
dotfiles, including completely new features and minor improvements to existing
functionality. Following these guidelines helps maintainers and the community
understand your suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please know that I've designed the
scripts as per my use case, hence there's not much changes required to it.
Exceptions are when I change my development environment or plan on automating
something else too. Hence, as you might've already figured, severe changes
aren't really required. But if there's a good enhancement you think will benefit
the greater good of all, please open a PR. Also, refer to the
[Pull Requests](#pull-requests) section for instruction on opening a PR. You can
fill up the [PR template](./PULL_REQUEST_TEMPLATE.md) & wait for a review.

#### Pull Requests

The process described here has several goals:

- Maintain a quality standard for easier maintainability of the Shell scripts.
- Fix problems that are important to users of the scripts.
- Engage the community in working toward the best possible way to automate
  setting up their own dev environment.
- Enable a sustainable system for the maintainer to review contributions.

Please follow these steps to have your contribution considered by the
maintainers:

1. Follow all instructions in [the template](./PULL_REQUEST_TEMPLATE.md)
2. Follow the [styleguides](#styleguides)
3. After you submit your pull request, verify that all
   [status checks](https://help.github.com/articles/about-status-checks/) are
   passing <details><summary>What if the status checks are failing?</summary>If
   a status check is failing, and you believe that the failure is unrelated to
   your change, please leave a comment on the pull request explaining why you
   believe the failure is unrelated. A maintainer will re-run the status check
   for you. If we conclude that the failure was a false positive, then we will
   open an issue to track that problem with our status check suite.</details>

## Styleguides

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move the cursor to..." not "Moves the cursor to...")
- Limit the first line to 80 characters or less
- Reference issues and pull requests liberally after the first line
- Consider starting the commit message with an applicable emoji:

  - :art: `:art:` when improving the format/structure of the code
  - :racehorse: `:racehorse:` when improving performance
  - :non-potable_water: `:non-potable_water:` when plugging memory leaks
  - :memo: `:memo:` when writing docs
  - :penguin: `:penguin:` when fixing something on Linux
  - :apple: `:apple:` when fixing something on macOS
  - :checkered_flag: `:checkered_flag:` when fixing something on Windows
  - :bug: `:bug:` when fixing a bug
  - :fire: `:fire:` when removing code or files
  - :green_heart: `:green_heart:` when fixing the CI build
  - :white_check_mark: `:white_check_mark:` when adding tests
  - :lock: `:lock:` when dealing with security
  - :arrow_up: `:arrow_up:` when upgrading dependencies
  - :arrow_down: `:arrow_down:` when downgrading dependencies
  - :shirt: `:shirt:` when removing linter warnings

  ...There are more available at [gitmoji](https://gitmoji.carloscuesta.me/).

### Shell Styleguide

All Shell scripts must adhere to Google's
[Shell Style Guide](https://google.github.io/styleguide/shellguide.html).

<!-- TODO: Add more documentation -->

### Documentation Styleguide

**This section needs to be updated properly, feel free to make a PR if you know
how to document dotfiles.**

As of now, the documentation exists on the [README.md](../README.md) but I think
it would be more efficient to include external documentation as the project
grows. Ideas are welcome but for now, please make sure to include enough
instructions & docs on the README itself if you make some changes.

## Additional Notes

### Pull Request Labels

This section lists the labels we use to help track & manage and pull requests.

[GitHub search](https://help.github.com/articles/searching-issues/) makes it
easy to use labels for finding groups of pull requests you're interested in. For
example, you might be interested in
[open pull requests in `jarmos/dotfiles` which haven't been reviewed yet](https://github.com/search?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+repo%3Ajarmos%2Fdotfiles+comments%3A0).
To help you find pull requests, each label is listed with search links for
finding open items with that label in `jarmos/dotfiles` only. it is recommended
to read about
[other search filters](https://help.github.com/articles/searching-issues/) which
will help you write more focused queries.

The labels are loosely grouped by their purpose, but it's not required that
every PR have a label from every group or that a PR can't have more than one
label from the same group.

<!-- TODO: List the current PR labels -->

### PR Labels

**Section will be updated eventually.**

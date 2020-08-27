<!--
TODO:
- Add some Documentation guidelines
- Fix the additional notes table with proper labels
-->

# Contributing to dotfiles

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing to my collection of [dotfiles](https://dotfiles.github.io/). They're meant to automate the process of setting up my ***personal Ubuntu development machine***. The scripts are hosted in this current repository on GitHub for backup purpose & a robust environment for packaging & distribution.

The following content in this file are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Table Of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[What should I know before I get started?](#what-should-i-know-before-i-get-started)

* [dotfiles](#dotfiles)
* [Project Design Decisions](#design-decisions)

[How Can I Contribute?](#how-can-i-contribute)

* [Reporting Bugs](#reporting-bugs)
* [Suggesting Enhancements](#suggesting-enhancements)
* [Your First Code Contribution](#your-first-code-contribution)
* [Pull Requests](#pull-requests)

[Styleguides](#styleguides)

* [Git Commit Messages](#git-commit-messages)
* [Shell Styleguide](#shell-styleguide)
* [Documentation Styleguide](#documentation-styleguide)

[Additional Notes](#additional-notes)

* [Issue and Pull Request Labels](#issue-and-pull-request-labels)

### Code of Conduct

This project and everyone participating in it is governed by the [CODE OF CONDUCT](https://github.com/Jarmos-san/.github/blob/master/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [somraj.mle@gmail.com](mailto:somraj.mle@gmail.com).

### I Don't Want To Read This Whole Thing I Just Have a Question

> **Note:** [Please don't file an issue to ask a question.](https://blog.atom.io/2016/04/19/managing-the-deluge-of-atom-issues.html) You'll get faster results by using the resources below.

The scripts hosted here in the repository works perfectly fine for me as expected. If you've some suggestions about writing certain aspects of the script in a better way, I welcome PRs for it.

Besides, if you've questions regarding my dev environment, feel free to tweet to me at--[@Jarmosan](https://twitter.com/Jarmosan). Or if you want a detailed explanation, feel free to have a discussion over at--[AMA - Jarmos](https://github.com/Jarmos-san/ama).

I've purposely disabled the "*Issues*" tab since the scripts work perfectly for my use case. ***You're free to use them but with discretion as they might've unintended actions to your filesystem***.

### What should I know before I get started

#### dotfiles

"*dotfiles*" refers to this reposity which hosts some shell scripts for setting up an automated development environment on my Ubuntu machine.

The scripts downloads & setups the following applications on my system:

1. Python

2. Docker

3. Poetry(Python package management system)

4. zsh(A Shell emulator)

and a few more...

It's not a application for you to download right way to use. Doing so can have unintended actions on your system, so if you do use some of the scripts or borrow a snippet or two, **know what you're doing**.

I strongly recommend going through the scripts to learn what each line are doing. When in doubt, feel free to reach out to me.

#### Design Decisions

The idea behind hosting all those scripts under one roof is for easier packaging & ditribution besides backup availability. The fact that one can setup a full-blown dev environment on their Ubuntu machine with a call of just a `wget` invocation or even a `git` clone makes hosting dotfiles in a remote repository very favourable.

Besides, there's also a Docker image available that's regularly updated when & if I see a need to automate certain aspects of my development environment. It's strongly recommended to give a try using these scripts inside a Docker container safely. That way, your system won't be changed by the scripts, yet you can still experience using it as if you're installing it for the first time.

### How Can I Contribute

#### Reporting Bugs

This section guides you through submitting a bug report for [dotfiles](https://github.com/jarmos-san/dotfiles). Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer: :computer:, and find related reports :mag_right:.

<!--TODO: Add a PR template here.-->
Before creating bug reports, please check [this list](#before-submitting-a-bug-report) as you might find out that you don't need to create one. When you are creating a bug report, please [include as many details as possible](#how-do-i-submit-a-good-bug-report). Fill out [the required template](https://github.com/atom/.github/blob/master/.github/ISSUE_TEMPLATE/bug_report.md), the information it asks for helps us resolve issues faster.

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for the dotfiles, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please know that I've designed the scripts as per my use case, hence there's not much changes required to it. Exceptions are when I change my development environment or plan on automating something else too. Hence, as you might've already figured, severe changes aren't really required. But if there's a good enhancement you think will benefit the greater good of all, please open a PR. Also kindly refer to the [Pull Requests](#pull-requests) section. You can fill up this PR template & wait for a review.

#### Pull Requests

The process described here has several goals:

* Maintain a quality standard for easier maintainability of the Shell scripts.

* Fix problems that are important to users of the scripts.

* Engage the community in working toward the best possible way to automate setting up their own dev environment.

* Enable a sustainable system for the maintainer to review contributions.

Please follow these steps to have your contribution considered by the maintainers:

1. Follow all instructions in [the template](./PULL_REQUEST_TEMPLATE.md)
2. Follow the [styleguides](#styleguides)
3. After you submit your pull request, verify that all [status checks](https://help.github.com/articles/about-status-checks/) are passing <details><summary>What if the status checks are failing?</summary>If a status check is failing, and you believe that the failure is unrelated to your change, please leave a comment on the pull request explaining why you believe the failure is unrelated. A maintainer will re-run the status check for you. If we conclude that the failure was a false positive, then we will open an issue to track that problem with our status check suite.</details>

While the prerequisites above must be satisfied prior to having your pull request reviewed, the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted.

### Styleguides

#### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line
* Consider starting the commit message with an applicable emoji:
  * :art: `:art:` when improving the format/structure of the code
  * :racehorse: `:racehorse:` when improving performance
  * :non-potable_water: `:non-potable_water:` when plugging memory leaks
  * :memo: `:memo:` when writing docs
  * :penguin: `:penguin:` when fixing something on Linux
  * :apple: `:apple:` when fixing something on macOS
  * :checkered_flag: `:checkered_flag:` when fixing something on Windows
  * :bug: `:bug:` when fixing a bug
  * :fire: `:fire:` when removing code or files
  * :green_heart: `:green_heart:` when fixing the CI build
  * :white_check_mark: `:white_check_mark:` when adding tests
  * :lock: `:lock:` when dealing with security
  * :arrow_up: `:arrow_up:` when upgrading dependencies
  * :arrow_down: `:arrow_down:` when downgrading dependencies
  * :shirt: `:shirt:` when removing linter warnings

    more availabe available at [gitmoji](https://gitmoji.carloscuesta.me/).

#### Shell Styleguide

All Shell scripts must adhere to Google's [Shell Style Guide](https://google.github.io/styleguide/shellguide.html).

<!-- TODO -->
### Documentation Styleguide

**This section needs to be updated properly, feel free to make a PR if you know how to document dotfiles.**

As of now, the documentation exists on the [README.md](../README.md) but I think it would be more efficient to include an external documentation as the project grows. Ideas are welcome but for now, please make sure to include enough instructions & docs on the README itself if you make some changes.

### Additional Notes

#### Pull Request Labels

This section lists the labels we use to help track & manage and pull requests.

[GitHub search](https://help.github.com/articles/searching-issues/) makes it easy to use labels for finding groups of pull requests you're interested in. For example, you might be interested in [open pull requests in `jarmos/dotfiles` which haven't been reviewed yet](https://github.com/search?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+repo%3Ajarmos%2Fdotfiles+comments%3A0). To help you find pull requests, each label is listed with search links for finding open items with that label in `jarmos/dotfiles` only. it is recommednde to read about [other search filters](https://help.github.com/articles/searching-issues/) which will help you write more focused queries.

The labels are loosely grouped by their purpose, but it's not required that every PR have a label from every group or that an PR can't have more than one label from the same group.

<!-- TODO -->
#### PR Labels

**Section will be updated eventually.**

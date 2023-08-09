# homebrew-custombrew

[Homebrew](https://brew.sh) formulae for `sshpass` and `retry`

## UPDATE NOTE

___This repository has been updated to correctly support the `homebrew-<repository>` URL Path expected by [newer versions of homebrew](https://github.com/Homebrew/brew/releases/latest) when installing custom taps and formulae.___

## Using custom Taps and Formulae from Github

### Syntax/Usage

Installing a tap from github is fairly straightforward.  For more information, please see the [Official Documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap#installing)

> If it’s on GitHub, users can install any of your formulae with ```brew install user/repo/formula```. Homebrew will automatically add your ```github.com/<user>/homebrew-<repo>``` tap before installing the formula.
>
> To install your tap without installing any formula at the same time, users can add it with the brew tap command. If it’s on GitHub, they can use ```brew tap user/repo```, where `user` is your _GitHub username_ and `homebrew-repo` is _your repository_. If it’s hosted outside of GitHub, they have to use `brew tap user/repo <URL>`, where `user` and `repo` will be used to refer to _your tap_ and `<URL>` is your _Git clone URL_.
>
> Users can then install your formulae either with ```brew install foo``` if there’s no core formula with the same name, or with ```brew install user/repo/foo``` to avoid conflicts.
require 'formula'

### Example: Installing sshpass from this repository

[ajanis/custombrew/sshpass](https://github.com/ajanis/homebrew-custombrew/sshpass/formula.rb)

Installing the formula: ```ajanis/custombrew/sshpass``` points to the repository and file at ```https://github.com/ajanis/homebrew-custombrew/sshpass/formula.rb```.

## Installation

### Install Homebrew

You will of course need to install [Homebrew](https://brew.sh), which you can quickly do with the following command:
  
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install the custom Tap 

```shell
❯ brew tap ajanis/custombrew

==> Tapping ajanis/custombrew
Cloning into '/opt/homebrew/Library/Taps/ajanis/homebrew-custombrew'...
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 13 (delta 1), reused 12 (delta 0), pack-reused 0
Receiving objects: 100% (13/13), done.
Resolving deltas: 100% (1/1), done.
Tapped 2 formulae (14 files, 10.9KB).

```

### Install the Formula

Currently there are 2 Formulae available from this repo:

- `sshpass`: A tool for non-interactive SSH login where a password is required
  
  __NOTE: This is considered extremely insecure.  You should use SSH Keys whenever possible and otherwise, use interactive password login!!__
  
  _This utility is for edge case laziness and (unless handled appropriately) will leave a cleartext password in your current terminal session and in your command history._

- `retry`: A tool for retrying shell commands
  Provided by 

```shell
brew install ajanis/custombrew/sshpass
brew install ajanis/custombrew/retry
```





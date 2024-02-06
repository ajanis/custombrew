d# homebrew-custombrew

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

Currently there is 1 Formula available:

- `sshpass`: A tool for non-interactive SSH login where a password is required
  
__NOTE: This is considered extremely insecure.  You should use SSH Keys whenever possible and otherwise, use interactive password login!!__
  
  _This utility is for edge case laziness and (unless handled appropriately) will leave a cleartext password in your current terminal session and in your command history._

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
remote: Enumerating objects: 16, done.
remote: Counting objects: 100% (16/16), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 16 (delta 2), reused 15 (delta 1), pack-reused 0
Receiving objects: 100% (16/16), done.
Resolving deltas: 100% (2/2), done.
Tapped 1 formula (13 files, 11.7KB).
```
```shell
❯ brew tap-info ajanis/custombrew

ajanis/custombrew: 1 formula
/opt/homebrew/Library/Taps/ajanis/homebrew-custombrew (13 files, 11.8KB)
From: https://github.com/ajanis/homebrew-custombrew
```

### Install the Formula

```shell
❯ brew install ajanis/custombrew/sshpass

==> Fetching ajanis/custombrew/sshpass
==> Downloading http://sourceforge.net/projects/sshpass/files/sshpass/1.06/sshpass-1.06.tar.gz
==> Downloading from https://cytranet.dl.sourceforge.net/project/sshpass/sshpass/1.06/sshpass-1.06.tar.gz
######################################################################################################################################################################################################################################################### 100.0%
==> Installing sshpass from ajanis/custombrew
==> Downloading https://formulae.brew.sh/api/formula.jws.json

==> ./configure
==> make install
==> Downloading https://formulae.brew.sh/api/cask.jws.json

🍺  /opt/homebrew/Cellar/sshpass/1.06: 8 files, 78.5KB, built in 17 seconds
==> Running `brew cleanup sshpass`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
```
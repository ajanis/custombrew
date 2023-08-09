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

### Homebrew

You will of course need to install [Homebrew](https://brew.sh), which you can quickly do with the following command:
  
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Tap Only

```shell
$ brew tap ajanis/custombrew

==> Tapping ajanis/custombrew
Cloning into '/opt/homebrew/Library/Taps/ajanis/homebrew-custombrew'...
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
Receiving objects: 100% (6/6), done.
Tapped (14 files, 8.3KB).
```

### Formula

```shell
brew install ajanis/custombrew/sshpass
brew install ajanis/custombrew/retry
```





# bigboybrew

Homebrew formula for `sshpass`

## Using custom Taps and Formulae from Github

Installing a tap from github is fairly [straightforward](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap#installing)

> If it’s on GitHub, users can install any of your formulae with ```brew install user/repo/formula```. Homebrew will automatically add your ```github.com/user/homebrew-repo``` tap before installing the formula. In this case, ```user/repo/formula``` points to the ```github.com/user/homebrew-repo/**/formula.rb``` file.
> 
> To install your tap without installing any formula at the same time, users can add it with the brew tap command. If it’s on GitHub, they can use ```brew tap user/repo```, where `user` is your _GitHub username_ and `homebrew-repo` is _your repository_. If it’s hosted outside of GitHub, they have to use `brew tap user/repo <URL>`, where `user` and `repo` will be used to refer to _your tap_ and `<URL>` is your _Git clone URL_.
> 
> Users can then install your formulae either with ```brew install foo``` if there’s no core formula with the same name, or with ```brew install user/repo/foo``` to avoid conflicts.
require 'formula'

## Specifics for this repo
- Install:
  ```brew install ajanis/custombrew/sshpass.rb```
- Tap Only:
  ```brew tap ajanis/custombrew```

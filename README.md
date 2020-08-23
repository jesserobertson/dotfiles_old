# dotfiles

My setup for Linux hosts - there are many dotfiles projects, but this one is
mine.

## Setup

We need a few dependencies prior to starting:

```sh
$ sudo apt install zsh fzf tig git 
```

and then you need to set your default shell to zsh with `chsh -s $(which zsh)`.

## Install dependencies and run

Fire up a shell and run

```console
> git clone git@github.com:jesserobertson/dotfiles.git ~/.dotfiles
> cd ~/.dotfiles
> script/install
> script/bootstrap
```

Then you should be able to open a new terminal and get dropped into a nice
environment :)

You can install components seperately, eg `rust/install.sh` - the bootstrap script just runs everything in sequence. 

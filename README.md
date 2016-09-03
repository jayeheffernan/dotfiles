# The .dotfiles of Jaye Heffernan

This repository contains my personal dotfiles for configuring my system.  Notably, my Vim and Zsh configurations are maintained here.

## How it works

The files are managed with git and [ stow ](https://www.gnu.org/software/stow/).  Stow is used for mass symlinking.  Most nice [ Zsh ](https://github.com/zsh-users/zsh) configuration is done automatically by [ Oh My Zsh ](https://github.com/robbyrussell/oh-my-zsh).  [ Vim ](http://www.vim.org/) plugins are managed by the excellent [ Vundle ](https://github.com/VundleVim/Vundle.vim).  Vim plugins are kept under version control only by their entry in `.vimrc`, with the exception of Vundle.  Tmux configuration is handled mostly by a TPM, the Tmux Plugin Manager, and a small `.tmux.conf` listing plugins and setting prefix to `ctrl-t`.  The structure, at the top level, is the following:

- .gitignore
- .gitmodules
- home (a stow package)
- any other future stow packages
- Makefile

`home` is a stow package, meaning that config files inside this directory will be mounted using symbolic links relative to some other directory, in this case `~`.  A `Makefile` is provided to deploy these packages.

## Deploying

To deploy all config file symlinks in to place:

`make`

To remove all symlinks:

`make clean`

To deploy a single package into place (e.g. home):

`make home`

To remove symlinks for a particular package:

`make clean-home`

## Pre/Post Requisites

- [ Curl ](https://github.com/curl/curl)

 `sudo apt-get install curl`

- [ Autojump ](https://github.com/wting/autojump)

 `sudo apt-get install autojump`

- [ Oh My Zsh ](https://github.com/robbyrussell/oh-my-zsh)

 `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

- [ Vim ](http://www.vim.org/) plugins

 Run [ Vundle's ](https://github.com/VundleVim/Vundle.vim) plugin install command.  From within vim: `:PluginInstall`

- [ tmux ](https://tmux.github.io/) plugins

 Hit `prefix-I` from within tmux to install tmux plugins

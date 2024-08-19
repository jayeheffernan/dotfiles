# My .dotfiles

Including Vim, Zsh, and helpful utilities.

## How it works

The files are managed with git and [ stow ](https://www.gnu.org/software/stow/).  Stow is used for mass symlinking.  Most nice [ Zsh ](https://github.com/zsh-users/zsh) configuration is done automatically by [ Oh My Zsh ](https://github.com/robbyrussell/oh-my-zsh).  [ Vim ](http://www.vim.org/) plugins are managed by the excellent [ Vundle ](https://github.com/VundleVim/Vundle.vim).  Vim plugins are kept under version control only by their entry in `.vimrc`, with the exception of Vundle.  Tmux configuration is handled mostly by a TPM, the Tmux Plugin Manager, and a small `.tmux.conf` listing plugins and setting prefix to `ctrl-t`.  The structure, at the top level, is the following:

- .gitignore
- .gitmodules
- home (a stow package)
- any other future stow packages
- Makefile

`home` is a stow package, meaning that config files inside this directory will be mounted using symbolic links relative to some other directory, in this case `~`.  A `Makefile` is provided to deploy these packages.

## Deploying

First, clone this repo.  From inside the repo, run

`git submodule init`

and

`git submodule update`

This will fetch Vundle and TPM.

To deploy all config file symlinks:

`make`

To remove all symlinks:

`make clean`

To deploy a single package into place (e.g. home):

`make home`

To remove symlinks for a particular package:

`make clean-home`

## Dependencies

[Kitty](https://sw.kovidgoyal.net/kitty/binary/)

```sh
mkdir -p ~/.config
mkdir -p ~/.builds

curl https://sh.rustup.rs -sSf | sh

# Skip setting up shell/path stuff, it's already in our config
curl https://get.volta.sh | bash -s -- --skip-setup
volta install node

brew install neovim fzf ripgrep moreutils autojump tree bat fd exa

gem install neovim
npm install -g neovim
python3 -m pip install --user --upgrade pynvim
python2 -m pip install --user --upgrade pynvim

git clone 'https://github.com/aaron-williamson/base16-alacritty' ~/.config
git clone 'https://github.com/chriskempson/base16-shell.git' ~/.config
git clone 'https://github.com/fnune/base16-fzf' ~/.config

base_16_material
```

## Updating base16 colors

To update to "ocean":

- Run `base_16_ocean` 
- Update `~/.config/alacritty/alacritty.yml`
- Update `~/.zshrc` with `source ~/.config/base16-fzf/bash/base16-ocean.config`
- `Preferences: Color Theme` in VSCode

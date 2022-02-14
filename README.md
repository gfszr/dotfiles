# Dotfiles

Contain all dotfiles and submodules required for my Vim setup, along with some ZSH configuration,
tmux and what not.

**Note:** Works out of the box on `macOS`, but should be fairly easy to port to any linux distro,
with the following changes:
* `tmux-spotify` doesn't work on linux. It can be replaced though. 
* Change the apple icon to tux :)

It looks like this:

![Demo](demo.gif)

## Installation

I've attached a very simple script `setup.sh` that removes prior configurations and creates symnolic
to the correct directories in this repo. 

The setup script does not install dependencies, so make sure to install prior dependencies,
otherwise some features may not work.

## Requirements

* `neovim >= 0.6.0`, with neovim python support (`pip3 install neovim`).
* `tmux >= 3.2`, for tmux floating popups, used both in .vimrc and tmux.conf.
* `zsh` with oh-my-zsh installation. Check [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) for reference. 
* `fzf` - for support using FZF integration with vim. 
* [lazygit](https://github.com/jesseduffield/lazygit) for a good git TUI through vim and tmux.
* `yarn` and `node`, in order for coc.nvim to work. Run `yarn install` in
  `nvim/pack/man/start/coc.nvim' after installation, other than using a precompiled release branch.

For extra configurations and useful installations, please refer to the recommendations section.

## Recommendations

Although not required and not attached, I use:

* [delta](https://github.com/dandavison/delta) - for nicer git diffs. Make sure to cnofigure your
  `.gitconfig` with diffing using delta. I use the following in my `.gitconfig`:
```
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true  # use n and N to move between diff sections
    side-by-side = true
    line-numbers = true
    paging = always

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default

```
* [bat](https://github.com/sharkdp/bat.git) - nicer replacement for `cat`. FZF integration in vim shows file previews with `bat`.
* Use `:CocInstall` to install coc.nvim plugins! I use [coc-jedi](https://github.com/pappasam/coc-jedi.git), [coc-go](https://github.com/josa42/coc-go.git), [coc-clangd](https://github.com/clangd/coc-clangd)
* If you wish, you can install [vista.vim](https://github.com/liuchengxu/vista.vim), useful for symbol searching.

## Patched fonts

I used [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) to patch `Monaco` with many nice
glyphs. I also recommend `Consolas`.

## Thanks

Almost all is based on amazing plugins and themes with no/small modifications. For easy upgrades in
the future, plugins are referenced as submodules. I've made modifications to the following:

* The tmux theme I am using is the amazing [maglev](https://github.com/caiogondim/maglev) by [caigondim](https://github.com/caiogondim), with only small modifications.


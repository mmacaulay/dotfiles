# dotfiles

Small personal dotfiles repo for a macOS `zsh` setup.

## What's here

- `zshrc`: interactive shell settings, prompt, aliases, `nvm`, `bun`
- `zshenv`: minimal non-interactive environment setup so Node is available to tools and scripts
- `gitconfig`: personal Git defaults
- `gitignore`: global Git ignore file
- `vimrc`: lightweight Vim config
- `inputrc`: readline settings
- `install`: symlinks the tracked files into `$HOME`

## Assumptions

- macOS
- `zsh` as the active shell
- Homebrew-installed `nvm` at `/opt/homebrew/opt/nvm/nvm.sh`
- `bun` installed at `$HOME/.bun`

## Install

Run:

```sh
./install
```

That will create or replace symlinks for:

- `~/.zshrc`
- `~/.zshenv`
- `~/.gitconfig`
- `~/.gitignore`
- `~/.inputrc`
- `~/.vimrc`

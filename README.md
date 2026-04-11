# dotfiles

Small personal dotfiles repo for a macOS `zsh` setup.

## What's here

- `zshrc`: interactive shell settings, prompt, aliases, and `mise` activation
- `zshenv`: minimal non-interactive environment setup so runtimes are available to tools and scripts
- `gitconfig`: personal Git defaults
- `gitignore`: global Git ignore file
- `.config/mise/config.toml`: global `mise` tool/runtime configuration
- `vimrc`: lightweight Vim config
- `inputrc`: readline settings
- `install`: symlinks the tracked files into `$HOME`

## Assumptions

- macOS
- `zsh` as the active shell
- `mise` installed to `$HOME/.local/bin/mise`

## Install

For a full new-machine bootstrap, run:

```sh
./bootstrap
```

If you only want to install the symlinks, run:

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
- `~/.config/mise/config.toml`

`bootstrap` also installs `mise` if needed, then runs:

```sh
mise trust ~/.config/mise/config.toml
mise install
mise reshim
```

# Version Manager Migration Plan

## Direction

Use:

- `mise` for installing and selecting versions of Python, Node, Ruby, and global developer tools
- `uv` installed globally via `mise`
- `uv` inside Python projects for virtual environments, dependencies, and execution

Do not keep separate managers for the same runtimes:

- remove `nvm`
- remove `pyenv`
- do not add `rbenv`

This keeps the machine setup simpler while still preserving the main Python-specific benefits of `uv`.

## Install And Remove

1. Install `mise` without letting it edit shell files:

   ```sh
   curl https://mise.run | sh
   ```

2. Add `mise` shims and binary location to shell startup files before relying on it:

   `zshenv` should include:

   ```sh
   export PATH="$HOME/.local/bin:$PATH"
   export PATH="$HOME/.local/share/mise/shims:$PATH"
   ```

3. Track the global config in this repo at `.config/mise/config.toml` and symlink it to:

   ```sh
   ~/.config/mise/config.toml
   ```

4. On a new machine, the simplest setup path is:

   ```sh
   ./bootstrap
   ```

5. If bootstrapping manually, after restarting the shell install baseline tools with:

   ```sh
   mise install
   ```

   Or, without the tracked config yet:

   ```sh
   mise use -g python@3.13
   mise use -g node@lts
   mise use -g ruby@3.3
   mise use -g uv@latest
   ```

6. Reshim after installs if needed:

   ```sh
   mise reshim
   ```

7. Remove old tools only after validation:

- uninstall `nvm` if it was installed with Homebrew
- remove `~/.nvm` after confirming Node workflows work under `mise`
- uninstall `pyenv` if it was installed with Homebrew
- remove `~/.pyenv` after confirming Python workflows work under `mise` and `uv`

## Repo Updates

Update `zshenv` to hold only non-interactive-safe environment setup:

```sh
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"
```

This is the important part for AI tools and any non-interactive `zsh` execution.

Update `zshrc` to remove:

- all `nvm` setup and the `.nvmrc` hook
- all `pyenv` exports and the lazy `pyenv()` wrapper

Keep `zshrc` for interactive-only behavior:

- prompt
- aliases
- completion
- `GPG_TTY=$(tty)`
- interactive `mise` activation:

  ```sh
  command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
  ```
This should stay out of `zshenv`.

## Version File Strategy

Prefer `mise.toml` for new projects.

That keeps version selection explicit and puts everything in one file.

For older repos that already use ecosystem-native files:

- `.nvmrc`
- `.python-version`
- `.ruby-version`

`mise` can support these idiomatic files, and the tracked global config enables them for easier migration, but they are not the best default for new work.

## AI / Non-Interactive Support

Design rule: anything AI tools need must come from `zshenv`, not `zshrc`.

That means:

- put `mise` shims on `PATH` in `zshenv`
- avoid `tty`, `compinit`, hooks, prompt logic, or `eval`-heavy init in `zshenv`
- do not depend on interactive shell hooks for tool resolution

Preferred usage in automation:

- Python:
  - `uv run ...`
  - `uv sync`
  - `uvx ...`
- Node:
  - plain `node`, `npm`, `pnpm`, `yarn`, etc. through `mise` shims
- Ruby:
  - plain `ruby`, `bundle`, `gem`, etc. through `mise` shims

## Validation

After the migration, test these in a non-interactive shell:

```sh
zsh -c 'command -v mise; command -v uv; command -v python; command -v node; command -v npm; command -v ruby; command -v bundle'
zsh -c 'python --version; node --version; ruby --version; uv --version'
```

Validate interactive shell behavior separately:

```sh
zsh -i -c 'command -v mise; command -v python; command -v node; command -v ruby'
```

Validate per-project behavior:

```sh
cd /path/to/python-project && uv run python --version
cd /path/to/node-project && node --version
cd /path/to/ruby-project && ruby --version
```

## Follow-Up Repo Work

When implementing this migration in the dotfiles repo:

1. update `zshenv` to the minimal `mise`-shim path setup
2. remove `nvm` and `pyenv` logic from `zshrc`
3. update `README.md` to document `mise` and `uv`
4. optionally add notes about `mise.toml` for future project setups

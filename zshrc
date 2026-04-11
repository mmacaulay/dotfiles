# Please no beeps
setopt NO_BEEP

# Globs
setopt NO_CASE_GLOB
setopt GLOB_COMPLETE

# Automatically CD into directories if you forget the 'cd'
setopt AUTO_CD

# Command history options
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST 
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000

# Suggest corrections to commands
# setopt CORRECT
# setopt CORRECT_ALL
unsetopt correct_all
unsetopt correct


### Autocomplete
autoload -Uz compinit && compinit

# Load bashcompinit for some old bash completions
# autoload bashcompinit && bashcompinit

### Prompt
PROMPT='%(?.%F{green}😀%f.%F{red}😬 [%?]%f) %F{blue}%m%f %F{cyan}%1~%f %F{yellow}%(!.#.%#)%f '

### Aliases
alias ls='ls --color -F -a -b -T'

export GPG_TTY=$(tty)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

# bun completions
[ -s "/Users/mac/.bun/_bun" ] && source "/Users/mac/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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
autoload -Uz compinit
# Only recheck completions once a day
if [[ -n ${ZDOTDIR:-~}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Load bashcompinit for some old bash completions
# autoload bashcompinit && bashcompinit

### Prompt
setopt PROMPT_SUBST

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{magenta}(%b)%f'

PROMPT='%(?.%F{green}😀%f.%F{red}😬 [%?]%f) %F{blue}%m%f %F{cyan}%1~%f${vcs_info_msg_0_} %F{yellow}%(!.#.%#)%f '

### Key bindings
bindkey '\e[1;3D' backward-word                    # Option+Left
bindkey '\e[1;3C' forward-word                     # Option+Right
bindkey '\e[A'    history-beginning-search-backward # Up arrow
bindkey '\e[B'    history-beginning-search-forward  # Down arrow
# Note: Option+Delete (delete word) requires a terminal-level mapping not supported
# in iTerm2 by default — use Ctrl+W instead

### Aliases
alias ls='ls -FA --color=auto'

export GPG_TTY=$(tty)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

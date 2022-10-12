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
setopt CORRECT
setopt CORRECT_ALL

### Autocomplete
autoload -Uz compinit && compinit

# Load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit

### Prompt
PROMPT='%(?.%F{green}😀%f.%F{red}😬 [%?]%f) %F{blue}%m%f %F{cyan}%1~%f %F{yellow}%(!.#.%#)%f '

### Aliases

# I always install gnu coreutils
alias ls='ls --color -F -a -b -T 0'

alias vim='nvim'
alias vi='nvim'

### Terminal Title

precmd () { echo -ne "\e]1;`print -P %~`\a" }

### Functions

# Syntax-highlight JSON strings or files
function json() {
	if [ -p /dev/stdin ]; then
		# piping, e.g. `echo '{"foo":42}' | json`
		python -mjson.tool | pygmentize -l javascript
	else
		# e.g. `json '{"foo":42}'`
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	fi
}

# Run Visual Studio Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

### Paths
export PATH="/usr/local/opt/grep/libexec/gnubin:/anaconda/bin:/usr/local/opt/coreutils/libexec/gnubin:~/.rbenv/bin:~/usr/local/opt/node@10/bin:/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export MANPATH="~/man:/usr/local/man:$MANPATH"

export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-11.0.1.jdk/Contents/Home"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

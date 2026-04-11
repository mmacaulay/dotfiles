# Makes node available in non-interactive shells (Claude Code, scripts, etc.)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/alias/default" ] && export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/default)/bin:$PATH"

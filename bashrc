# ~/.bashrc: executed by bash(1) for non-login shells.
#[ -n "$PS1" ] && source ~/.bash_profile

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
#[ -f /Users/mac/.travis/travis.sh ] && source /Users/mac/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/mac/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/mac/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/mac/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/mac/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/mac/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /Users/mac/.nvm/versions/node/v10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
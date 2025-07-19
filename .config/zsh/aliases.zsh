#
# Aliases
#

# Enable aliases to be sudo’ed
#   http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

_exists() {
  command -v $1 > /dev/null 2>&1
}

# Just because clr is shorter than clear
alias clr='clear'

# Go to the /home/$USER (~) directory and clears window of your terminal
alias q="cd ~ && clear"

# Folders Shortcuts - Cross-platform (checks both cases for system dirs)
[ -d ~/Downloads ] && alias dl='cd ~/Downloads' || [ -d ~/downloads ] && alias dl='cd ~/downloads'
[ -d ~/Desktop ]   && alias dt='cd ~/Desktop'   || [ -d ~/desktop ]   && alias dt='cd ~/desktop'

# Personal project directories - lowercase preferred
[ -d ~/projects ]             && alias pj='cd ~/projects'
[ -d ~/projects/forks ]       && alias pjf='cd ~/projects/forks'
[ -d ~/projects/playground ]  && alias pjp='cd ~/projects/playground'
[ -d ~/projects/repos ]       && alias pjr='cd ~/projects/repos'

# Commands Shortcuts
alias e='$EDITOR'
alias x+='chmod +x'

# Open aliases
alias open='open_command'
alias o='open'
alias oo='open .'
alias finder='open .'

# Terminal launcher - OS-specific
case "$(uname -s)" in
    Darwin*)
        alias term='open -a ghostty.app'
        ;;
    Linux*)
        alias term='ghostty &'
        ;;
esac

# Run scripts
alias update="$DOTFILES/scripts/update"

# Quick jump to dotfiles
alias dotfiles="code $DOTFILES"

# Quick reload of zsh environment
alias reload="source $ZDOTDIR/.zshrc"

# My IP - OS-specific network commands
case "$(uname -s)" in
    Darwin*)
        alias myip='ifconfig | sed -En "s/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p"'
        ;;
    Linux*)
        alias myip='ip route get 1.1.1.1 | grep -oP "src \K\S+"'
        ;;
esac

# Show $PATH in readable view
alias path='echo -e ${PATH//:/\\n}'

# Download web page with all assets
alias getpage='wget --no-clobber --page-requisites --html-extension --convert-links --no-host-directories'

# Download file with original filename
alias get="curl -O -L"

# Use tldr as help util
if _exists tldr; then
  alias help="tldr"
fi

# Docker
alias dcd="docker compose down"
alias dcu="docker compose up"
alias dl="docker logs"

# git
alias git-root='cd $(git rev-parse --show-toplevel)'
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

# ls with fallback
if _exists lsd; then
  alias ls >/dev/null 2>&1 && unalias ls
  alias ls='lsd'
  alias lt='lsd --tree'
else
  case "$(uname -s)" in
    Darwin*)
      alias ls='ls -G'  # macOS color flag
      ;;
    Linux*)
      alias ls='ls --color=auto'  # GNU ls color flag
      ;;
  esac
fi

# cat/bat with fallback
if _exists bat; then
  alias cat='bat --paging=never'
fi

# Ping with fallback
if _exists prettyping; then
  alias ping='prettyping'
fi

# dirs
alias d='dirs -v'
for index in {1..9}; do alias "$index"="cd +${index}"; done; unset index

# Quick jump to dotfiles directory
alias dotf='cd ~/.dotfiles'
alias dotfiles="cd ~/.dotfiles"

# Smart trash management - cross-platform
if _exists trash-put; then
  # trash-cli is available - use it for safety
  alias rm='trash-put'
  alias trash='trash-put'           # Shorter alias
  alias trash-ls='trash-list'       # List trash contents  
  alias trash-restore='trash-restore'
  alias trash-empty='trash-empty'
  alias trash-rm='trash-rm'         # Permanently delete from trash
else
  # Fallback for systems without trash-cli
  echo "trash-cli not found - using interactive rm for safety" >&2
  alias rm='rm -i'  # Interactive confirmation
fi

# Keep original rm available for when you really need it
alias \rm='command rm'  # Force original rm (escape the alias)

# NCDU disk usage analyzer
if _exists ncdu; then
  alias du='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
  alias space='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
  alias diskusage='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
fi

# Visual Studio Code
alias vsc='code'     # Shorter alias for Visual Studio Code
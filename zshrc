# cozy zsh config. Based off Luke's cause im not that smart. Fedora btw.

# Enable colors and change prompt:
autoload -U colors && colors
function rgb_color {
  local r=$1
  local g=$2
  local b=$3
  echo "%{\e[38;2;${r};${g};${b}m%}"
}
PS1="%B%{$(rgb_color 128 128 128)%}[%{$(rgb_color 153 153 0)%}%n%{$(rgb_color 128 128 128)%}@%{$(rgb_color 76 153 0)%}%M %{$(rgb_color 128 128 128)%}%~%{$(rgb_color 122 156 127)%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init zsh)"

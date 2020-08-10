if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi

PROMPT=$'[$(tty | grep -o -E "[0-9]+")] %{$fg[$NCOLOR]%}%n%{$reset_color%}@%M %{$fg[cyan]%}%c%{$reset_color%} '
RPROMPT='%{$fg[yellow]%}%p $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# See https://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"


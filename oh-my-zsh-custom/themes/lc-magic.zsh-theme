# af-magic.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

# color vars
eval my_red='$FG[196]'
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'
eval my_green='$FG[082]'
eval my_blue='$FG[032]'
eval my_lightblue='$FG[105]'

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Primary prompt
# Using orange hostname on the left side would be:
# $my_orange%m%{$reset_color%} $my_blue%~\
PROMPT='$my_gray------------------------------------------------------------%{$reset_color%}
%{$reset_color%} $my_blue%~\
$(git_prompt_info) \
$my_lightblue%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# right prompt
if [ $UID -eq 0 ]; then NCOLOR=$my_red; else NCOLOR=$my_green; fi
if type "virtualenv_prompt_info" > /dev/null
then
	RPROMPT='$(virtualenv_prompt_info)$NCOLOR%n@%m%{$reset_color%}%'
else
	RPROMPT='$NCOLOR%n@%m%{$reset_color%}%'
fi

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

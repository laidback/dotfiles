# lc-magic.zsh-theme
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

# color vars
eval my_red='$FG[196]'
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'
eval my_green='$FG[082]'
eval my_blue='$FG[032]'
eval my_lightblue='$FG[105]'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# vim mode settings
eval my_vim_ind='$my_green'
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
        eval my_vim_ind='$my_lightblue'
    ;;
    $ZVM_MODE_INSERT)
        eval my_vim_ind='$my_green'
    ;;
    $ZVM_MODE_VISUAL)
        eval my_vim_ind='$my_orange'
    ;;
    $ZVM_MODE_VISUAL_LINE)
        eval my_vim_ind='$my_orange'
    ;;
    $ZVM_MODE_REPLACE)
        eval my_vim_ind='$my_red'
    ;;
  esac
}

# Primary prompt
# Using orange hostname on the left side would be:
# $my_orange%m%{$reset_color%} $my_blue%~\
#PROMPT='$my_gray------------------------------------------------------------%{$reset_color%}
PROMPT='%{$reset_color%} $my_blue%~ $(git_prompt_info) 
$my_vim_ind%(!.#.»)%{$reset_color%} '
#$my_lightblue%(!.#.»)%{$reset_color%} '

# set right prompt color
if [ $UID -eq 0 ]; then
    NCOLOR="red";
else
    NCOLOR="green";
fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# set right prompt color
if [ $UID -eq 0 ]; then
    NCOLOR=$my_red;
else
    NCOLOR=$my_green;
fi

# set virtualenv prompt
if type "virtualenv_prompt_info" > /dev/null
then
    RPROMPT='$my_orange$(virtualenv_prompt_info) $(kube_ps1) $NCOLOR%n@%m%{$reset_color%}%'
fi


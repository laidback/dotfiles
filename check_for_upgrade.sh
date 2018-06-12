#!/usr/bin/env zsh

# TODO:
# write last upgrade to a file, so you do not check on every login

zmodload zsh/datetime

function _current_epoch() {
  echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}

function _update_dotfiles_update() {
  echo "LAST_EPOCH=$(_current_epoch)" >! ~/.dotfiles-update
}

function _upgrade_dotfiles() {
    echo "upgrading dotfiles"
    git fetch --all --prune
    git pull --all
}

# Cancel upgrade if the current user doesn't have write permissions for the
# dotfiles directory.
[[ -w "$DOTFILES" ]] || return 0

# Cancel upgrade if git is unavailable on the system
whence git >/dev/null || return 0

if mkdir "$DOTFILES/log/update.lock" 2>/dev/null; then
    echo "[Dotfiles] Would you like to check for updates? [Y/n]: \c"
    read line
    if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
        _upgrade_dotfiles
    fi
fi


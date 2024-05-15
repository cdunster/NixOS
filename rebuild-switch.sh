#!/bin/sh
today=`date +%Y.%m.%d`
last_commit=`git log -1 --pretty=%B`
branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
revision=`git describe --always --dirty`
export NIXOS_PROFILE="$branch"
export NIXOS_LABEL_VERSION="$today+${last_commit// /_}.$revision"
echo "rebuilding and switching to NixOS with profile $NIXOS_PROFILE and label: $NIXOS_LABEL_VERSION"
sudo nixos-rebuild switch -p "$NIXOS_PROFILE"

#!/bin/sh

branch=`(git branch 2>/dev/null | sed -n '/^\* / { s|^\* ||; p; }')`
export NIXOS_PROFILE="$branch"
if [[ $NIXOS_PROFILE == "main" ]]; then
    echo "rebuilding NixOS and switching to it"
    sudo nixos-rebuild switch
else
    echo "rebuilding and switching to NixOS with profile $NIXOS_PROFILE"
    sudo nixos-rebuild switch -p "$NIXOS_PROFILE"
fi

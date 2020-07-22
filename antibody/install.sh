#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew tap | grep -q 'getantibody/tap' || brew tap getantibody/tap
	brew install antibody
else
	mkdir -p ~/.local/bin
	curl -sL https://git.io/antibody | sh -s -- -b ~/.local/bin
fi
antibody bundle <"$DOTFILES/antibody/bundles.txt" >~/.zsh_plugins.sh
antibody update

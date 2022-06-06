#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew tap | grep -q 'getantidote/tap' || brew tap getantidote/tap
	brew install antidote
else
	mkdir -p ~/.local/bin
	git clone https://github.com/mattmc3/antidote.git ~/.antidote
fi
. ~/.antidote/antidote.zsh
antidote bundle <"$DOTFILES/antidote/bundles.txt" >~/.zsh_plugins.zsh

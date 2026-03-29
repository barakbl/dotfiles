#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
BREW_APPS=(fd nerdfetch docker zsh-autosuggestions zplug lsd lazygit tmux btop git  fzf zsh starship stow)

echo "=============="
echo "Dotfiles Setup"
echo "=============="
echo

############### install brew packages ######################
function brew_inst() {
	if ! command -v $1 &> /dev/null; then
		echo "$1 is not installed. Installing..."
		brew install $1
		echo "$1 installed successfully!"
	else
		echo "$1 installed already, skip"
	fi
	echo ""
}

for app in "${BREW_APPS[@]}"; do
	brew_inst $app
done

#brew tap homebrew/cask-fonts
#brew install --cask font-blex-mono-nerd-font
############ End brew ##################################=


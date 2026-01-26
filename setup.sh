#!/bin/bash
set -e

# Clone the repository if it doesn't exist
if [[ ! -d "$HOME/dotfiles" ]]; then
    echo "Cloning the repository to ~/dotfiles..."
    git clone https://github.com/valfink/dotfiles.git "$HOME/dotfiles"
    cd "$HOME/dotfiles" || exit
else
    cd "$HOME/dotfiles" || exit
    echo "Repository already exists in ~/dotfiles. Continuing with the existing repository."
fi

# Set the DOTFILES_ENV environment variable
export DOTFILES_ENV="work"


./dependencies.sh
./stow.sh


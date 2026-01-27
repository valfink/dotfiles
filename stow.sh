#!/bin/bash
set -e

stow_folder() {
    local target="$1"
    local source="$2"

    # Check if both parameters are provided
    if [[ -z "$target" || -z "$source" ]]; then
        echo "Usage: stow_with_target_check <target> <source>"
        return 1
    fi

    # Create the target directory if it doesn't exist
    if [[ ! -d "$target" ]]; then
        echo "Target directory '$target' does not exist. Creating it..."
        mkdir -p "$target"
    fi

    # Run the stow command
    printf "Running stow command for: %20s -> %s\n" "$source" "$target"
    stow -t "$target" "$source"
}

# Stow links the folders in the repository to the specified config locations so that the system finds them
case "$DOTFILES_ENV" in
    work)
        stow_folder "$HOME/.config/aerospace/" aerospace
        stow_folder "$HOME/" zsh
        stow_folder "$HOME/" ideavim
        stow_folder "$HOME/Library/Application Support/Code/User/" vscode
        stow_folder "$HOME/.config/github-copilot/intellij/" copilot-prompts
        stow_folder "$HOME/Library/Application Support/Code/User/prompts/" copilot-prompts
        ;;
    *)
        echo "Invalid DOTFILES_ENV value. Please set it to 'work'."
        exit 1
        ;;
esac


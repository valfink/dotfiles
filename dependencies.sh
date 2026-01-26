#!/bin/bash
set -e

install_omz() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    # Install Oh My Zsh
    echo "Installing Oh My Zsh..."
    echo
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "Oh My Zsh is already installed."
  fi

  P10KDIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  if [[ ! -d $P10KDIR ]]; then
    echo "Downloading Powerlevel10K..."
    echo
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $P10KDIR
  else
    echo "Powerlevel10K is already downloaded."
  fi
}

install_brew() {
  which -s brew
  if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Installing Homebrew..."
    echo
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew is already installed. Updating..."
    echo
    brew update
  fi
}

install_packages() {
  echo "Installing Homebrew packages..."
  echo
  local package_file=$1
  while IFS='' read -r line || [[ -n "$line" ]]; do
    if brew list --versions "$line" > /dev/null || brew list --casks "$line" > /dev/null;  then
      echo "$line is already installed."
    else
      echo "Installing $line..."
      brew install "$line"
    fi
  done < "$package_file"
  echo "Finished installing Homebrew packages."
  echo
}

case "$DOTFILES_ENV" in
  work)
    install_brew
    install_packages "./brew-work.txt"
    install_omz
    ;;
  *)
    echo "Invalid DOTFILES_ENV value. Please set it to 'work'."
    exit 1
    ;;
esac



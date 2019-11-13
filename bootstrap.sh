#!/usr/bin/env bash

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

success_final () {
    success "Nothing else to do!"
    exit 0
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [Y/n]" response
    case $response in
        [yY][eE][sS]|[yY]|"") 
            true
            ;;
        *)
            false
            ;;
    esac
}

if xcode-select --install 2>&1 | grep installed; then
    info "Command line tools are already installed, proceed."
fi

# Check if Homebrew is already there
if ! which brew 2>&1 > /dev/null; then
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    info "Homebrew is already installed, let's make sure it's up to date (brew update)."
    brew update
fi

if [ ! -d ~/.oh-my-zsh ] && confirm "Replace bash with (oh-my) zsh?"; then
    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ -f ~/.zshrc ] && confirm "Install zsh completions?"; then
    brew install zsh-completions
    echo 'fpath=(/usr/local/share/zsh-completions $fpath)' >> ~/.zshrc
else
    info "~/.zshrc not found, skipping zsh-completions as well"
fi

if [ -z "$HOMEBREW_CASK_OPTS" ]; then
    if confirm "Install brew cask apps under /Applications (it's more predictable than default behavior)?"; then
        # Make Brew Cask install programs in a more predictable location
        cask_opts="HOMEBREW_CASK_OPTS=--appdir=/Applications"
        export $cask_opts
        shell_dot_file="$HOME/.zshrc"
        if [ ! -f "$shell_dot_file" ]; then
            shell_dot_file="$HOME/.bash_profile"
        fi
        echo $cask_opts >> $shell_dot_file
        info "$cask_opts has been added to $shell_dot_file"
    fi
fi

# TODO: Confirm setting the zsh plugins to certain list 

if confirm "Next step installs everything defined in Brewfile - review them BEFORE you hit ENTER!"; then
    # Following will install everything from Brewfile
    info "Depending on the packages you install, you might get promped for your password several times."
    brew bundle
fi

brew cleanup
success_final
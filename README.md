# Setup OS X for Development

This is my personal process to setup a new OS X for productive development environment. The guide below outlines the 
steps needed to install `Command Line Tools`, [brew](http://brew.sh/), update integrated shell tools, install `zsh` and 
customise it with the truly awesome zsh framework [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), install popular
software for development, as well as everyday programs.

Finally, I have added my personal `.gitconfig` file with handy shortcuts and tools to support 
[GitHub Flow](https://guides.github.com/introduction/flow/) workflow. It is meant to be forked, customised with your 
personal software list and ran.

**All steps are automated with a a `bootstrap.sh` script** that does that with few prompts to confirm each step. 

## How to use this repository

1. Fork this repository and clone your fork.
2. Customise `Brewfile` with your favorite list of programs you want installed, especially the cask part.
3. If you don't want `zsh`, remove the steps in `bootstrap.sh` (or just enter `n` when prompted on the wizard).
4. Run `./bootstrap.sh`.
5. Customize your `~/.zshrc` file with [theme](https://wiki.github.com/robbyrussell/oh-my-zsh/themes) (default is nice, 
but my favorite is "pygmalion") and [plugins](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins).

## What does it do

First things first, get Xcode installed. Open `Terminal` and write:

```bash
xcode-select --install
```

Next, let's install [brew](http://brew.sh/), it makes it easy to install and
manage basically every piece of software on your Mac.

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor # to verify everything went smoothly
brew update
```

[Cask](https://github.com/caskroom/homebrew-cask) is used to install 3rd party software (like `Java`, `Google Chrome`, 
`IntelliJ IDEA` and thousands of others). As of December 2015, `cask` comes bundled with Homebrew so you can directly 
try to do `brew cask search iterm`, see that the actual package name is `iterm2` and install it with 
`brew cask install iterm2`.

Now that Brew is installed, we can install everything. This is my list of favorite packages. Customize it to your taste.

```bash
brew install bash-completion # autocomplete in bash (tabbing) for many tools
brew install gcc # this will take a while...
brew install git # although git comes with OS X, this way we get the latest version
brew install mtr # network diagnostic tool, useful when somebody asks "did the internet just stop?"
brew install tig # ncurses based UI for git, just tig in a repo
brew install fpp # facebook path picker, do a `git status | fpp` to see what it can do
brew install nmap # network security scanner
brew install shellcheck # shell script analyzer
brew install python
brew install wget
brew install node
brew install htop
brew install nano
brew install make

# Cask installs third party applications
brew cask install google-chrome
brew cask install visual-studio-code # open source text editor, has cool VCS features
brew cask install caffeine # keeps your Mac awake when you want to
brew cask install flux # adjusts the color temperature of your monitor to ease it on your eyes
brew cask install dropbox
brew cask install github
brew cask install java # includes JDK
brew cask install iterm2 # great terminal replacement
brew cask install little-snitch
brew cask install skype
brew cask install slack
brew cask install sourcetree # Great GUI for Git, Subversion and Mercurial
brew cask install spectacle # Easy window management
brew cask install spotify # Free music :)
brew cask install vagrant # Great to manage development environments (requires VM software)
brew cask install virtualbox # Free VMs, `vmware-fussion` is much better but requires $$$
```

Many Mac utils are not GNU compatible and might cause headaches for users accustomed to Linux shells. We can fix that.

```bash
brew install coreutils findutils bash # gnu core utils instead of the old and weird ones shipped with MacOS
brew tap homebrew/dupes
brew install homebrew/dupes/grep # grep is not part of coreutils
```

However `coreutils` are installed with `g` prefix by default. We will prepend them to our path **later** (when we 
install a *better* shell) so we don't have to use `gls` instead of `ls` for example. If this is too much of a hassle to 
type every time, you can add a "gnubin" directory to your PATH and just call GNU `ls` with `ls`. You will need to add 
the following to your `~/.zshrc` (or `~/.bash_profile` in case you stick with bash):

```bash
echo 'PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
```

### Run Windows applications on OS X

If you want to be able to run Windows applications under your Mac, you can do so with [wine](https://www.winehq.org/). However, it requires [XQuartz](http://xquartz.macosforge.org/landing/).

```bash
brew cask install xquartz # Needed for wine, it will take ages to install, be patient
```

Now that you have `xquartz`, you can install `wine`.

```bash
brew install wine # run windows programs on your Mac
```

I'm a huge fan of `zsh` as a [better](http://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692)
alternative to `bash`. After we activate `zsh`, we install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), which 
will let us customize our shell with some neat completion plugins and git bonuses.

```bash
brew install zsh zsh-completions
# Activate it as your new default shell. If you get an "chsh: Operation is not supported..." error, read below.
chsh -s $(which zsh)
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### chsh: Operation is not supported ...

If you happen to have a network account on `Open Directory` server, attempting to switch your shell with `chsh` will 
give you a message like:

```
chsh: Operation is not supported by the directory node.  Operation is not supported by the directory node.
chsh: no changes made
```

There is a workaround - we can activate `zsh` everytime we open a shell.

```bash
echo 'export SHELL=$(which zsh)' >> ~/.bash_profile
echo 'exec $(which zsh) -l' >> ~/.bash_profile
```

# macbook-bootstrap
This is my personal process to setup a new Mac for productive development
environment.

First things first, get Xcode installed. Open `Terminal` and write:

```bash
xcode-select —install
```

Next, let's install [brew](http://brew.sh/), it makes it easy to install and
manage basically every piece of software on your Mac.

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor # to verify everything went smoothly
brew update
```

Now that Brew is installed, we can start by updating some of the core Mac tools.

```bash
brew install coreutils findutils bash # gnu core utils instead of the old and weird ones shipped with MacOS
brew tap homebrew/dupes
brew install homebrew/dupes/grep # grep is not part of coreutils
```

However `coreutils` are installed with `g` prefix by default. We will prepend them
to our path **later** (when we install a *better* shell) so we don't have to use
`gls` instead of `ls` for example.

[Cask](https://github.com/caskroom/homebrew-cask) is used to install 3rd party software (like `Java`, `Google Chrome`, or `IntelliJ IDEA`).

```bash
brew install caskroom/cask/brew-cask
```

With `cask` in hand, we can setup everything else. Customize the following lists
to your taste.

```bash
brew install bash-completion # autocomplete in bash (tabbing) for many tools
brew install git
brew install mtr # network diagnostic tool, you will use it when somebody asks "did the internet just stop?"
brew install nmap # network security scanner
brew install node
brew install shellcheck # shell script analyzer
brew install wget

brew cask install atom # text editor by GitHub
brew cask install caffeine # keeps your Mac awake when you want to
brew cask install dropbox
brew cask install flux # amazing tool that adjusts the color temperature of your monitor to ease it on your eyes
brew cask install github
brew cask install google-chrome
brew cask install java # includes JDK
brew cask install iterm2 # great terminal replacement
brew cask install little-snitch
brew cask install macvim
brew cask install intellij-idea-ce # The Ultimate (paid) version is just `intellij-idea`
brew cask install skype
brew cask install slack
brew cask install sourcetree # Great GUI for Git, Subversion and Mercurial
brew cask install spectacle # Easy window management
brew cask install spotify # Free music :)
brew cask install vagrant # Great to manage development environments (requires VM software)
brew cask install virtualbox # Free VMs, `vmware-fussion` is much better but requires $$$
brew cask install xquartz # Needed for wine, it will take ages to install, be patient
brew cask install wine # run windows programs on your Mac
```

Now that we have most of our software installed, we can proceed by setting up a
*better* shell - namely `zsh`. On top of it, we will setup [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and customize it. Open
`iterm2`.

```bash
brew install zsh
```

Normally you would change your default shell by executing:

```bash
chsh -s $(which zsh)
```

BUT if you happen to have a network account on `Open Directory` server, that will
give you a message like:

```
chsh: Operation is not supported by the directory node.  Operation is not supported by the directory node.
chsh: no changes made
```

In this case we will have to make a workaround, activating `zsh` everytime you open a shell.

```bash
echo 'export SHELL=$(which zsh)' >> ~/.bash_profile
echo 'exec $(which zsh) -l' >> ~/.bash_profile
```

Open a new tab and you are ready to install `oh-my-zsh`.

```bash
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
```

#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cp -nv ~/.bashrc ~/.bashrc.bak
cp -nv ~/.profile ~/.profile.bak
cp -nv ~/.zshrc ~/.zshrc.bak

if [ $(uname) = "Darwin" ]
then
    ~/loadrc/bashrc/ln_fs.sh ~/loadrc/macos/.bashrc ~/.bashrc
else
    ~/loadrc/bashrc/ln_fs.sh ~/loadrc/.bashrc ~/.bashrc
fi

~/loadrc/bashrc/ln_fs.sh ~/loadrc/.zshrc ~/.zshrc
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.profile ~/.profile
~/loadrc/bashrc/ln_fs.sh ~/loadrc/oh-my-zsh ~/.oh-my-zsh

# mv -fv ~/.config/git/gitk ~/.config/git/gitk.bak
~/loadrc/bashrc/ln_fs.sh ~/loadrc/."`hostname`".theanorc  ~/.theanorc
# ~/loadrc/bashrc/ln_fs.sh ~/loadrc/.config/git/gitk  ~/.config/git/gitk
# sed -i.bak "s/set ignorespace 0/set ignorespace 1/g" $(which gitk)
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.ssh ~/.ssh
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.tmux.conf ~/.tmux.conf
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.config/tig/config ~/.config/tig/config
~/loadrc/bashrc/ln_fs.sh ~/loadrc/gitrc/.gitconfig ~/.gitconfig
~/loadrc/bashrc/ln_fs.sh ~/loadrc/gitrc/.globalgitignore ~/.globalgitignore
~/loadrc/bashrc/ln_fs.sh ~/loadrc/pythonrc/setup.cfg  ~/setup.cfg
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.hgrc ~/.hgrc
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.hgignore ~/.hgignore
# ~/loadrc/bashrc/ln_fs.sh ~/loadrc/Library/Preferences/org.videolan.vlc/vlcrc ~/Library/Preferences/org.videolan.vlc/vlcrc
~/loadrc/bashrc/ln_fs.sh ~/loadrc/iterm2rc/movescreen.py ~/Library/ApplicationSupport/iTerm2/Scripts/movescreen/movescreen/movescreen.py
# ~/loadrc/bashrc/ln_fs.sh ~/loadrc/.kdiff3rc ~/.kdiff3rc
~/loadrc/bashrc/ln_fs.sh ~/loadrc/.tigrc ~/.tigrc

./set_linux_configuration.sh
./set_macos_configuration.sh
./set_host_configuration.sh
./neovim/post.sh

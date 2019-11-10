SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

cp -nv ~/.bashrc ~/.bashrc.bak
cp -nv ~/.profile ~/.profile.bak
cp -nv ~/.zshrc ~/.zshrc.bak

if [ !$(uname) = "Darwin" ]
then
    ln -fs ~/loadrc/.bashrc ~/.bashrc
else
    ln -fs ~/loadrc/macos/.bashrc ~/.bashrc
    ln -fs ~/loadrc/macos/.zshrc ~/.zshrc
fi

ln -fs ~/loadrc/.profile ~/.profile

mv -fv ~/.config/git/gitk ~/.config/git/gitk.bak
ln -fs "$SCRIPTPATH" ~/loadrc
ln -fs ~/loadrc/."`hostname`".theanorc  ~/.theanorc
ln -fs ~/loadrc/.config/git/gitk  ~/.config/git/gitk
#ln -fs ~/loadrc/.ssh ~/.ssh
ln -fs ~/loadrc/.tmux.conf ~/.tmux.conf
ln -fs ~/loadrc/gitrc/.gitconfig ~/.gitconfig
ln -fs ~/loadrc/gitrc/.globalgitignore ~/.globalgitignore
ln -fs ~/loadrc/pythonrc/setup.cfg  ~/setup.cfg
ln -fs ~/loadrc/.hgrc ~/.hgrc
ln -fs ~/loadrc/.hgignore ~/.hgignore
ln -fs ~/loadrc/Library/Preferences/org.videolan.vlc/vlcrc ~/Library/Preferences/org.videolan.vlc/vlcrc
ln -fs ~/loadrc/iterm2rc/movescreen.py ~/Library/ApplicationSupport/iTerm2/Scripts/movescreen/movescreen/movescreen.py
#ln -fs ~/loadrc/.kdiff3rc ~/.kdiff3rc

./set_linux_configuration.sh
./set_host_configuration.sh

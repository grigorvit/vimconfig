#!/bin/sh
INSTALL_TO=~/Projects

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

[ -e "$INSTALL_TO/vimconfig" ] && die "$INSTALL_TO/vimconfig already exists."
[ -e "~/.vim" ] && die "~/.vim already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

cd "$INSTALL_TO"
git clone git://github.com/grigorvit/vimconfig.git
cd vimconfig

# Download vim plugin bundles
git submodule init
git submodule update

# Compile command-t for the current platform
#cd vim/ruby/command-t
#(ruby extconf.rb && make clean && make) || warn "Ruby compilation failed. Ruby not installed, maybe?"

# Symlink ~/.vim and ~/.vimrc
cd ~
ln -s "$INSTALL_TO/vimconfig/vimrc" .vimrc
ln -s "$INSTALL_TO/vimconfig/vim" .vim
touch ~/.vim/user.vim

echo "Installed and configured .vim, have fun."

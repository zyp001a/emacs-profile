rm -rf ../.emacs.d
cp -r .emacs.d ../.
ln -s .emacs ../.
echo "alias e='emacs -nw'" >>../.bashrc

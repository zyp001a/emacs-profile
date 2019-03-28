rm -f ../.emacs.d
ln -s .emacs.d ../.
ln -s .emacs ../.
echo "alias e='emacs -nw'" >>../.bashrc

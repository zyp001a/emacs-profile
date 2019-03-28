rm -rf ../.emacs.d
cp -r .emacs.d ../.
cd .. && ln -s emacs-profile/.emacs . && cd emasc-profile
echo "alias e='emacs -nw'" >>../.bashrc

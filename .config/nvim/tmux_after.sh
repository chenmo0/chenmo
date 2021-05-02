if test -r ~/.config/nvim/.ghost
then
    ghost=$(cat ~/.config/nvim/.ghost)
    rm -f ~/.config/nvim/.ghost
    eval $ghost
fi

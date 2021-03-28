inoremap jj <Esc>
nnoremap ,vv gg0<c-v>G=''
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
colorscheme desert
set nocp cindent cursorline showmatch
set ts=4 sts=4 et shiftwidth=4
set rnu nu
set hlsearch incsearch

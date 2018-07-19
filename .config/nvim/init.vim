set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
nnoremap <c-space> :call CSCSearch(4)<CR><CR>

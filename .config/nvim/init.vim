set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
nnoremap <c-space> :call CSCSearch()<CR><CR>
nmap <C-d> :!rm expand("%:p")<CR><CR>

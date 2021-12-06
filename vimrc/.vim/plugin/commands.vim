au BufEnter * set noro
" Don't let Vim's "Found a swap file" message block input
set shortmess=filnxtToOFA
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

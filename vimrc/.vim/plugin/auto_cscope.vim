function! s:auto_cscope()
    call UpdateProj()
endfunction

augroup auto_cscope
    au!
    au BufWritePost,TextChanged * call <SID>auto_cscope()
augroup END

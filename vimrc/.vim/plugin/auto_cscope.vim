function! s:auto_cscope()
    if &buftype ==# 'terminal'
        return
    endif

    call UpdateProj()
endfunction

augroup auto_cscope
    au!
    au BufWritePost,TextChanged * call <SID>auto_cscope()
augroup END

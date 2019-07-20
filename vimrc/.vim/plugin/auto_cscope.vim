function! s:auto_cscope()
    if (&buftype ==# 'terminal')  || (&filetype ==# 'gitcommit') || (&filetype ==# '') || (&filetype ==# 'fugitive') 
        return
    endif

    call UpdateProj()
endfunction

augroup auto_cscope
    au!
    au BufWritePost,TextChanged * call <SID>auto_cscope()
augroup END

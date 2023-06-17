function! SetUpDiffOptions()
    let l:file_ext = expand('%:e')
    let l:file_name = expand('%:t')

    if (l:file_ext !=# 'py' && l:file_name !=# 'readme')
        set diffopt+=iwhiteall
    else
        set diffopt-=iwhiteall
    endif

    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic
endfunction

autocmd BufEnter * call SetUpDiffOptions()

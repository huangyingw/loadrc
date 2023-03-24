function! SetUpDiffOptions()
    if (expand('%:e') !=# 'py')
        set diffopt+=iwhiteall
    else
        set diffopt-=iwhiteall
    endif

    set diffopt+=iblank
    set diffopt+=algorithm:patience
    set diffopt+=indent-heuristic
endfunction

autocmd BufEnter * call SetUpDiffOptions()

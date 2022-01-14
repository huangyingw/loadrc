function! s:rediff_augroup()
    if (expand("%") !~ '.*.diff')
        return
    endif

    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/rediff.sh ' . '"' .  expand("%:p") . '"'
endfunction

augroup rediff_augroup
    au!
    au BufWritePost * call <SID>rediff_augroup()
augroup END

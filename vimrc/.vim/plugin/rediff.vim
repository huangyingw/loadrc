function! s:rediff_augroup()
    if !&diff
        return
    endif

    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/rediff.sh ' . '"' .  expand("%:p") . '"'
endfunction

augroup rediff_augroup
    au!
    au BufWritePost,TextChanged * call <SID>rediff_augroup()
augroup END

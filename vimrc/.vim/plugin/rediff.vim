function! s:rediff_augroup()
    let worktree = Cd2Worktree()
    silent exec '!~/loadrc/gitrc/rediff.sh ' . '"' .  expand("%:p") . '"'
endfunction

augroup rediff_augroup
    au!
    au BufWritePost *.diff call <SID>rediff_augroup()
augroup END

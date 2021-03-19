function! s:auto_deploy_augroup()
    if &buftype ==# 'terminal'
        return
    endif

    call Cd2ProjectRoot('files.proj')
    call asyncrun#run('<bang>', '', '~/loadrc/bashrc/deploy.sh 2>&1 | tee deploy.findresult')
    call CHANGE_CURR_DIR() 
endfunction

augroup auto_deploy_augroup
    au!
    au BufWritePost,TextChanged * call <SID>auto_deploy_augroup()
augroup END

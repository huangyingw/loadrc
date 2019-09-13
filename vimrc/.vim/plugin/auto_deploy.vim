function! s:auto_deploy_augroup()
    call Cd2ProjectRoot('files.proj')
    call asyncrun#run('<bang>', '', 'bash ~/loadrc/bashrc/deploy.sh 2>&1 | tee deploy.findresult')
endfunction

augroup auto_deploy_augroup
    au!
    au BufWritePost,TextChanged * call <SID>auto_deploy_augroup()
augroup END

function! s:auto_deploy_augroup()
    let csdbpath = Find_in_parent("files.proj", Windowdir(), "/")
    exec "cd " . csdbpath
    call asyncrun#run('<bang>', '', 'bash ~/loadrc/bashrc/deploy.sh 2>&1 | tee deploy.findresult')
endfunction

augroup auto_deploy_augroup
    au!
    au BufWritePost,TextChanged * call <SID>auto_deploy_augroup()
augroup END

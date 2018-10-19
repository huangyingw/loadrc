function! s:auto_deploy_augroup()
    let b:auto_deploy_disable = (&buftype ==# "terminal")  || (&filetype ==# "gitcommit") || (&filetype ==# '')

    if b:auto_deploy_disable
        return
    endif

    let csdbpath = Find_in_parent("files.proj", Windowdir(), "/")
    exec "cd " . csdbpath
    call asyncrun#stop('<bang>')
    call asyncrun#stop('<bang>')
    call asyncrun#stop('<bang>')
    call asyncrun#run('<bang>', '', 'bash ~/loadrc/bashrc/deploy.sh 2>&1 | tee deploy.findresult')
endfunction

augroup auto_deploy_augroup
    au!
    au BufWritePost,TextChanged * call <SID>auto_deploy_augroup()
augroup END

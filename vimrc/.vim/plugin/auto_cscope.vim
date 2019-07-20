augroup auto_cscope
    au!
    au BufWritePost,TextChanged * call <SID>auto_deploy_augroup()
augroup END

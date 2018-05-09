"
"==
" Cycle_csdb
"  cycle the loaded cscope db.
function s:Cycle_csdb()
    let newcsdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    "echo "Found files.proj at: " . newcsdbpath
    if newcsdbpath == "/"
        let newcsdbpath = "osroot"
    endif
    if newcsdbpath == "Nothing"
        let newcsdbpath = "osroot"
    endif
    if newcsdbpath != "Nothing"
        return newcsdbpath
    endif
endfunc

function! ShowVITAG()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    exec "cd " . b:csdbpath
    exe 'vs files.proj'
    vert resize
endfunction

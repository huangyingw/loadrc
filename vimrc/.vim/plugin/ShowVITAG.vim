"
"==
" Cycle_csdb
"  cycle the loaded cscope db.
function s:Cycle_csdb()
    let newcsdbpath = Find_in_parent("cscope.out",Windowdir(),"/")
    "echo "Found cscope.out at: " . newcsdbpath
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
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    exec "cd " . b:csdbpath
    exe 'vs cscope.findresult'
    vert resize
endfunction

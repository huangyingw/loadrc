function! ShowVITAG()
    let csdbpath = Find_in_parent("files.proj", Windowdir(), "/")

    if csdbpath == "Nothing"
        return 
    endif

    exec "cd " . csdbpath
    call OpenOrSwitch('files.proj', 'vs')
endfunction

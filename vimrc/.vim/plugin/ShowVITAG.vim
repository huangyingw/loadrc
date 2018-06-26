function! ShowVITAG()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    exec "cd " . b:csdbpath
    call OpenOrSwitch('files.proj')
    vert resize
endfunction

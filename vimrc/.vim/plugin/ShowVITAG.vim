function! ShowVITAG()
    call Cd2Worktree()
    call Cd2ProjectRoot("files.proj")
    call OpenOrSwitch('files.proj', 'vs')
endfunction

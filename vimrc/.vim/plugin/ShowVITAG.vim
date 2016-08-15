"==
" windowdir
"  Gets the directory for the file in the current window
"  Or the current working dir if there isn't one for the window.
"  Use tr to allow that other OS paths, too
function s:windowdir()
  if winbufnr(0) == -1
    let unislash = getcwd()
  else 
    let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')
  endif
  return tr(unislash, '\', '/')
endfunc
"
"==
" Cycle_csdb
"  cycle the loaded cscope db.
function s:Cycle_csdb()
  let newcsdbpath = Find_in_parent("cscope.out",s:windowdir(),"/")
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
  let cur_dir = s:Cycle_csdb()
  let cur_dir = substitute(cur_dir, '.*/', "", "")
  let cur_dir = "/export/home1/username/cscope_db/".cur_dir
  exe 'vs '.cur_dir
  vert resize
endfunction

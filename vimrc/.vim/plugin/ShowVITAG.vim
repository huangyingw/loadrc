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
  let cur_dir = s:Cycle_csdb()
  let cur_dir = substitute(cur_dir, '.*/', "", "")
  let cur_dir = "/export/home1/username/cscope_db/".cur_dir
  exe 'vs '.cur_dir
  vert resize
endfunction

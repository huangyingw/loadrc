fun! JavaCodeFormatter()
  let s:hostname = substitute(system("hostname"), '\n', '', '')
  if s:hostname == "scl-1yihuang-m.corporate.local"
    let &formatprg = "~/bin/eclipse/eclipse -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -quiet -config ~/loadrc/vimrc/.vim/ftplugin/org.eclipse.jdt.core.prefs ".expand('%:p')
    exe "!".&formatprg
  endif
endfunction
au! BufWritePost <buffer> call JavaCodeFormatter()

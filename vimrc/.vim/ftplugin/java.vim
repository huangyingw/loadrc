fun! JavaCodeFormatter()
  let s:hostname = substitute(system("hostname"), '\n', '', '')
  if s:hostname == "Yings-MacBook-Pro.local"
    let &formatprg = "~/eclipse/jee-mars/Eclipse.app/Contents/MacOS/eclipse -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -quiet -config ~/loadrc/vimrc/.vim/ftplugin/org.eclipse.jdt.core.prefs ".expand('%:p')
    exe "!".&formatprg
  endif
endfunction
au! BufWritePost <buffer> call JavaCodeFormatter()

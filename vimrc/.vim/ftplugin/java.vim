fun! JavaCodeFormatter()
  let &formatprg = "~/bin/eclipse/eclipse -nosplash -application org.eclipse.jdt.core.JavaCodeFormatter -config ~/loadrc/vimrc/.vim/ftplugin/org.eclipse.jdt.core.prefs ".expand('%:p')
  exe "!".&formatprg
endfunction
au! BufWritePost <buffer> call JavaCodeFormatter()

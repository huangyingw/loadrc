function! PopulatePasteBufferFromOSX()
  let @+ = system('pbpaste-remote')
  normal! gvp
  
endfunction
  
nnoremap <silent> cp :call PopulatePasteBufferFromOSX()<cr>
vnoremap <silent> cp :call PopulatePasteBufferFromOSX()<cr>

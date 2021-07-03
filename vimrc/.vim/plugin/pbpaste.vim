function! PopulatePasteBufferFromOSX()
  let @+ = system('pbpaste-remote')
  normal! "+p
endfunction

nnoremap <silent> cp :call PopulatePasteBufferFromOSX()<cr>

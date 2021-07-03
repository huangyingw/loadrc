function! PopulatePasteBufferFromOSX()
  " let @+ = system('nc localhost 2225')
  let @+ = system('pbpaste-remote')
  echom @+
  echo "done"
endfunction

nnoremap <silent> cp :call PopulatePasteBufferFromOSX()<cr>

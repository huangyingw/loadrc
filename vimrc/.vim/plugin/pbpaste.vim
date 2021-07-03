function! PopulatePasteBufferFromOSX(cmd)
    let @+ = system('pbpaste-remote')
    if a:cmd == 'v'
        normal! gvp
    else
        normal! "+p
    endif

endfunction

nnoremap <silent> cp :call PopulatePasteBufferFromOSX('n')<cr>
vnoremap <silent> cp :call PopulatePasteBufferFromOSX('v')<cr>

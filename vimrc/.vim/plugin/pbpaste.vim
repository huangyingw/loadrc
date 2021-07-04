function! PopulatePasteBufferFromOSX(mode)
    let @+ = system('pbpaste-remote')
    if a:mode== 'v'
        normal! gvp
    else
        normal! "+p
    endif

endfunction

nnoremap <silent> cp :call PopulatePasteBufferFromOSX('n')<cr>
vnoremap <silent> cp :call PopulatePasteBufferFromOSX('v')<cr>

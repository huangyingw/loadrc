function! PopulatePasteBufferFromOSX(mode)
    if &clipboard == 'unnamed'
        let @* = system('pbpaste-remote')
    else
        let @@ = system('pbpaste-remote')
    endif

    if a:mode== 'v'
        normal! gvp
    else
        normal! "+p
    endif

endfunction

nnoremap <silent> cp :call PopulatePasteBufferFromOSX('n')<cr>
vnoremap <silent> cp :call PopulatePasteBufferFromOSX('v')<cr>

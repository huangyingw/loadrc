let g:airline#extensions#branch#enabled = 1

function! FileTimestamp()
    if !empty(getftime(expand('%')))
        return strftime('%Y-%m-%d %H:%M', getftime(expand('%')))
    endif
    return ''
endfunction

let g:airline_section_z = airline#section#create_right(['%{FileTimestamp()}'])

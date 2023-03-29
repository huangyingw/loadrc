function! FileTimestamp()
    if !empty(getftime(expand('%')))
        return strftime('%Y-%m-%d %H:%M', getftime(expand('%')))
    endif
    return ''
endfunction

let g:airline_section_z = airline#section#create_right(['%{FileTimestamp()}'])
let g:airline_extensions = ['branch']

" Enable git branch information in vim-airline
let g:airline#extensions#branch#enabled = 1

"" Custom function to display git status information
"function! AirlineGitStatus()
"    if !exists("*fugitive#statusline")
"        return ''
"    endif
"
"    let l:status = fugitive#statusline()
"
"    " Remove the branch name, since it's already displayed by vim-airline
"    let l:branch_removed = substitute(l:status, '\(.\{-}∙\s\?\)', '', '')
"    " return l:branch_removed
"    return l:status
"endfunction
"
"" Add git status to airline section
"let g:airline_section_y = airline#section#create(['%{AirlineGitStatus()}'])

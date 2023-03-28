function! FileTimestamp()
    if !empty(getftime(expand('%')))
        return strftime('%Y-%m-%d %H:%M', getftime(expand('%')))
    endif
    return ''
endfunction

let g:airline_section_z = airline#section#create_right(['%{FileTimestamp()}'])
let g:airline_extensions = ['branch']
let g:airline#extensions#branch#displayed_head_limit = 20

" Enable git branch information in vim-airline
let g:airline#extensions#branch#enabled = 1

" Enable git status information in vim-airline
function! AirlineGitStatus()
    let l:git_status = get(g:, 'airline#extensions#branch#flags', {})
    let l:status = ''
    if !empty(gitgutter#hunks#summary())
        for [l:sign, l:count] in items(gitgutter#hunks#summary())
            let l:status .= l:count . get(l:git_status, l:sign, l:sign)
        endfor
    endif
    return l:status
endfunction

" Add git status to airline section
let g:airline_section_c = airline#section#create(['%{AirlineGitStatus()}'])

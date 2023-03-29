function! GitBranch()
    let branch = FugitiveHead(0)
    return branch !=# '' ? ' (' . branch . ')' : ''
endfunction

function! GitFileStatus()
    let status = fugitive#statusline()
    if status ==# ''
        return ''
    endif

    let items = {
                \ 'A': 'Added',
                \ 'M': 'Modified',
                \ 'D': 'Deleted',
                \ '?': 'Untracked',
                \ 'U': 'Unmerged',
                \ 'T': 'Type Changed',
                \ 'R': 'Renamed',
                \ 'C': 'Copied'
                \ }

    let result = []
    for [abbr, text] in items
        if status =~# abbr
            call add(result, text)
        endif
    endfor
    return join(result, ', ')
endfunction

function! GitFileInfo()
    let info = GitFileStatus()
    return info !=# '' ? ' [' . info . ']' : ''
endfunction


set statusline=%r%h
set statusline +=\ %.55F            "full path
set statusline +=\ %{WordCount()}\ words,
set statusline +=%=        " Switch to the right side
set statusline +=\ %{strftime('%m/%d/%y\ %H:%M:%S',getftime(expand('%')))} " file last modified time
set statusline +=\ %l             "current line
set statusline +=/%L               "total lines
set statusline +=\ %v             "virtual column number
set statusline +=\ %f
set statusline +=\ %m                "modified flag
set laststatus=2 "black status line at bottom of window

if has("win32")
    set statusline+=\ %<%f%h%m%r%=%{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}\ %{&ff}\ %l,%c%V\ %P
else
    set statusline+=\%{strftime(\"%m/%d/%y\ %H:%M:%S\")}
endif

set statusline +=\ %{GitBranch()}

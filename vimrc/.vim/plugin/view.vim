" set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
"set statusline=[%n]\%f%m%r%h
set statusline=%r%h
set statusline +=\ %.55F            "full path
set statusline +=\ %{WordCount()}\ words,
set statusline +=\ %{GitBranch()},
set statusline +=%=        " Switch to the right side
set statusline +=\ %{strftime('%m/%d/%y\ %H:%M:%S',getftime(expand('%')))} " file last modified time
set statusline +=\ %l             "current line
set statusline +=/%L               "total lines
set statusline +=\ %v             "virtual column number
set statusline +=\ %m                "modified flag
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%2*0x%04B\ %*          "character under cursor
" Split previously opened file ('#') in a split window
set laststatus=2 "black status line at bottom of window
if has("win32")
    set statusline+=\ %<%f%h%m%r%=%{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}\ %{&ff}\ %l,%c%V\ %P
else
    set statusline+=\%{strftime(\"%m/%d/%y\ %H:%M:%S\")}
endif
syn match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
hi link ipaddr Identifier
set completeopt-=preview
syntax enable
set background=dark
set cursorline
"highlight cursorline cterm=NONE ctermbg=darkred ctermfg=NONE
"set cursorcolumn
"highlight cursorcolumn cterm=NONE ctermbg=darkred ctermfg=white

if &diff
    set winwidth=1
else
    set winwidth=999999
endif

set wrap
"set iskeyword-=_

function! GitBranch()
    let branch = FugitiveHead(0)
    return branch !=# '' ? ' (' . branch . ')' : ''
endfunction

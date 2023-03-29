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

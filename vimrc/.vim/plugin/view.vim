" set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\
"set statusline=[%n]\%f%m%r%h
set statusline=%r%h
set statusline +=\ %.65F            "full path
set statusline+=\ %{WordCount()}\ words,
set statusline +=%=        " Switch to the right side            
set statusline +=\ %l             "current line
set statusline +=/%L               "total lines
set statusline +=\ %v             "virtual column number
set statusline +=\ %f                
set statusline +=\ %m                "modified flag
"set statusline +=%1*\ %n\ %*            "buffer number
"set statusline +=%5*%{&ff}%*            "file format
"set statusline +=%3*%y%*                "file type
"set statusline +=%2*0x%04B\ %*          "character under cursor
set cursorline                  " underline the current line, for quick orientation
" Split previously opened file ('#') in a split window
set laststatus=2 "black status line at bottom of window
if has("win32")
  set statusline+=\ %<%f%h%m%r%=%{strftime(\"%I:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}\ %{&ff}\ %l,%c%V\ %P
else
  set statusline+=\%h%r%=%{strftime(\"%l:%M:%S\")}
endif

" Just like windo, but restore the current window when done.
function! WinDo(command)
  let currwin=winnr()
  execute 'windo ' . a:command
  execute currwin . 'wincmd w'
endfunction
com! -nargs=+ -complete=command Windo call WinDo(<q-args>)

" Just like Windo, but disable all autocommands for super fast processing.
com! -nargs=+ -complete=command Windofast noautocmd call WinDo(<q-args>)

" Just like bufdo, but restore the current buffer when done.
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

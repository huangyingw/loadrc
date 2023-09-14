au BufEnter * set noro
" Don't let Vim's "Found a swap file" message block input
set shortmess+=A
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Define a new command that calls ExecuteScriptInLoop function
command! StartScriptLoop call ExecuteScriptInLoop()

" The function to execute the script in a loop
function! ExecuteScriptInLoop()
  while 1
    " Check if there's an open file, if not, break the loop
    if bufname('%') == ''
      break
    endif
    " Execute your script and pass the current filename
    let s:output = system('/root/loadrc/bashrc/run_once_script_checker.sh ' . shellescape(bufname('%')))
    echo s:output
    " Pause for 2 seconds
    sleep 2
  endwhile
endfunction

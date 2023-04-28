function! AsyncRunShellCommand(cmd)
  let jobid = jobstart(a:cmd, {'on_stdout': 'AsyncRunShellCommand_on_stdout', 'on_stderr': 'AsyncRunShellCommand_on_stderr', 'on_exit': 'AsyncRunShellCommand_on_exit'})
endfunction

function! AsyncRunShellCommand_on_stdout(jobid, data, event)
  " process stdout data if needed
endfunction

function! AsyncRunShellCommand_on_stderr(jobid, data, event)
  " process stderr data if needed
endfunction

function! AsyncRunShellCommand_on_exit(jobid, exitcode, event)
  " process exit event if needed
endfunction

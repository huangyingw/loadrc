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

function! SendCurrentFileContentToPython()
    " 获取当前文件的目录路径
    let current_dir = expand('%:p:h') . '/'
    
    " 读取当前文件的所有行作为文件路径列表
    let relative_paths = readfile(expand('%'))
    
    " 移除路径字符串中开头的"./"和末尾的双引号
    let absolute_paths = map(copy(relative_paths), 'substitute(substitute(v:val, ''^"\./'', "", ""), ''"$'', "", "")')
    
    " 将绝对路径列表转换为一个字符串，每个路径由换行符分隔
    let paths_str = join(absolute_paths, "\n")
    
    " 使用临时文件存储绝对路径列表
    let temp_file = tempname()
    call writefile(split(paths_str, "\n"), temp_file)
    
    " 构建调用外部 Python 脚本的命令，同时重定向输出到日志文件
    let log_file = expand('~/renderpumlfiles.runresult')
    let python_script = expand('~/loadrc/pythonrc/send_paths.py')
    let command = 'python ' . shellescape(python_script) . ' ' . shellescape(temp_file) . ' 2>&1 | tee ' . shellescape(log_file)
    
    " 执行外部命令
    execute '!' . command
    
    " 可选：删除临时文件
    call delete(temp_file)
    
    " 可选：打开或切换到日志文件
    call OpenOrSwitch(log_file, 'vs')
endfunction

command! RenderPumlFiles call SendCurrentFileContentToPython()

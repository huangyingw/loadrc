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
    let worktree = Cd2Worktree()
    " 获取当前文件的目录路径
    let current_dir = expand('%:p:h') . '/'
    
    " 读取当前文件的所有行作为文件路径列表
    let relative_paths = readfile(expand('%'))
    
    " 移除路径中的开头 "./"（包括处理双引号的情况）和末尾的双引号
    let processed_paths = map(relative_paths, 'substitute(substitute(v:val, ''^"\./'', "", ""), ''"$'', "", "")')
    
    " 使用当前目录路径拼接
    let absolute_paths = map(processed_paths, 'current_dir . v:val')

    " 将处理后的绝对路径列表转换为一个字符串，每个路径由换行符分隔
    let paths_str = join(absolute_paths, "\n")
    
    " 使用临时文件存储绝对路径列表
    let temp_file = tempname()
    call writefile(split(paths_str, "\n"), temp_file)
    
    " 构建调用外部 Python 脚本的命令，同时重定向输出到日志文件
    let log_file = expand('renderpumlfiles.runresult')
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

" 定义一个函数用于比较两个窗口中的文件
function! CompareWithKdiff3()
    " 确保只有两个窗口打开
    if winnr('$') != 2
        echo "需要且仅需要两个窗口打开"
        return
    endif

    " 获取第一个窗口中文件的全路径
    let file1 = fnamemodify(bufname(winbufnr(1)), ':p')
    " 获取第二个窗口中文件的全路径
    let file2 = fnamemodify(bufname(winbufnr(2)), ':p')

    " 对文件路径中的空格进行转义
    let file1_escaped = shellescape(file1, 1)
    let file2_escaped = shellescape(file2, 1)

    " 使用kdiff3比较这两个文件
    " 注意：这里假设kdiff3可以在你的环境变量PATH中找到
    " 如果kdiff3的路径不在PATH中，需要指定完整路径
    execute '!/usr/local/bin/kdiff3' file1_escaped file2_escaped
endfunction

" 定义一个简短的Vim命令调用这个函数
command! Kdiff3 call CompareWithKdiff3()

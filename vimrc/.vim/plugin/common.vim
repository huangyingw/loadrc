function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")

    try
        exec "cd " . fnameescape(_dir)
    catch /.*/
        return
    endtry

    unlet _dir

    if filereadable(".vimdc")
        source .vimdc
    endif
endfunction
"
" autoclose html/xml tag autocmd BufNewFile,BufRead *.html,*.htm,*.xml inoremap </ </<c-x><c-o>
function! RemovePairs()
    let l:line = getline(".")
    let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符

    if index(["(", "[", "{"], l:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")

        " 如果没有匹配的右括号
        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        endif

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            " 如果右括号是当前行最后一个字符
            execute "normal! v%xa"
        else
            " 如果右括号不是当前行最后一个字符
            execute "normal! v%xi"
        endif
    else
        execute "normal! a\<BS>"
    endif
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")] " 取得当前光标后一个字符

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    endif
endfunction

" 获取当前路径，将$HOME转化为~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction

function! MyFoldText()
    let line = getline(v:foldstart)
    if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
            if comment_content != ''
                break
            endif
            let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
    else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace == '}'
                let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
        endif
    endif
    let n = v:foldend - v:foldstart + 1
    let info = " " . n . " lines"
    let sub = sub . "                                                                                                                  "
    let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
    let fold_w = getwinvar( 0, '&foldcolumn' )
    let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
    return sub . info
endfunction

function! ResCur()
    if line("'\"") <= line("$")
        try
            normal! g`"
        catch /./
        endtry

        return 1
    endif
endfunction

function! FindFileUpwards(file, stopdir) abort
    let l:cwd = getcwd()
    let l:current_dir = l:cwd

    while !filereadable(l:current_dir . '/' . a:file)
        let l:parent_dir = fnamemodify(l:current_dir, ':h')

        if l:parent_dir == l:current_dir || l:parent_dir == a:stopdir
            break
        endif

        let l:current_dir = l:parent_dir
    endwhile

    if filereadable(l:current_dir . '/' . a:file)
        return l:current_dir
    else
        return l:cwd
    endif
endfunction

function! GetGitWorkDirOrCurrentDir()
    " Get the absolute path of the current file's directory
    let l:current_dir = expand('%:p:h')

    " Wrap the current directory path with single quotes
    let l:current_dir_quoted = "'" . l:current_dir . "'"

    " Execute 'git rev-parse --absolute-git-dir' and get the output
    let l:absolute_git_dir = system('git -C ' . l:current_dir_quoted . ' rev-parse --absolute-git-dir')

    " Check if the command executed successfully
    if v:shell_error == 0
        " Remove the trailing newline character
        let l:absolute_git_dir = substitute(l:absolute_git_dir, '\n\+$', '', '')

        " Check if it's a submodule by looking for '/modules/' in the absolute_git_dir
        if l:absolute_git_dir =~ '/modules/'
            " Get the submodule path
            let l:submodule_path = substitute(l:absolute_git_dir, '/\.git/modules/[^/]*', '', '')

            " Return the submodule path
            return l:submodule_path
        else
            " Get the parent directory of the .git folder
            let l:parent_dir = fnamemodify(l:absolute_git_dir, ':h')

            " Return the parent directory
            return l:parent_dir
        endif
    else
        " If not inside a git repo, return the current directory
        return l:current_dir
    endif
endfunction

function! OpenOrSwitch(buffername, openMode, ...)
    " If buffername is "./vimrc/.vimrc:55", don't cut
    let fileName = a:buffername

    " Split the buffer name and check if the second part is not a number
    let parts = split(fileName, ':')
    if len(parts) > 1 && parts[1] !~ '^\d\+$'
        let fileName = parts[0]
    endif

    " Check if the file is readable, otherwise try to get the file name from the current line
    if !filereadable(a:buffername)
        let curline = getline(line("."))
        let curline = substitute(curline, '\\', '', 'g')
        let curline = substitute(curline, '^"', '', '')
        let curline = substitute(curline, '"$', '', '')
        if filereadable(curline)
            let fileName = curline
        endif
    endif

    " Use the topleft argument if provided, otherwise default to 'topleft'
    let topleft = (a:0 >= 1) ? a:1 : 'topleft'

    " Open the file in the specified mode ('goto' or 'vs')
    if a:openMode ==? 'goto'
        call fetch#cfile(fileName, 'e')
    else
        call fetch#cfile(fileName, 'vs')
    endif
endfunction

"==
" windowdir
"  Gets the directory for the file in the current window
"  Or the current working dir if there isn't one for the window.
"  Use tr to allow that other OS paths, too
function! Windowdir()
    if winbufnr(0) == -1
        let unislash = getcwd()
    else
        let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')

        if unislash =~ '^term://'
            let unislash = getcwd()
        endif

        if unislash =~ '^fugitive:/'
            let unislash = substitute(unislash, '^fugitive:\/\/', '', 'g')
            let unislash = substitute(unislash, '.git.*', '', 'g')
        endif
    endif

    return tr(unislash, '\', '/')
endfunc

function! GetEscapedKeyword(keywordStr)
    let result = a:keywordStr
    let result = substitute(result, '/', '\/', 'g')
    let result = substitute(result, '\"', '\\"', 'g')
    let result = substitute(result, '\$', '\\$', 'g')
    let result = substitute(result, '^\_s\+', '', 'g')
    let result = substitute(result, '\_s\+$', '', 'g')
    let result = substitute(result, '\_s', ' ', 'g')
    let result = substitute(result, '\n', '\\n', 'g')
    let result = substitute(result, '`', '\\`', 'g')
    let result = substitute(result, '\#', '\\#', 'g')
    let result = substitute(result, '!', '\\!', 'g')
    return result
endfunc

function! GetEscapedResult(keywordStr)
    let result = a:keywordStr
    try
        let result = substitute(result, " ", "", "g")
        let result = substitute(result, "/", "", "g")
        let result = substitute(result, "|", "", "g")
        let result = substitute(result, "(", "", "g")
        let result = substitute(result, ")", "", "g")
        let result = substitute(result, '\\c', '', 'g')
        let result = substitute(result, '\\V', '', 'g')
        let result = substitute(result, '\"', '', 'g')
        let result = substitute(result, '\,', '', 'g')
        let result = substitute(result, '\\', '', 'g')
        let result = substitute(result, '\$', '', 'g')
        let result = substitute(result, '#', '', 'g')
        let result = substitute(result, '!', '', 'g')
        let result = substitute(result, "<", "", "g")
        let result = substitute(result, ">", "", "g")
        let result = substitute(result, "~", "", "g")
        let result = substitute(result, "*", "", "g")
        let result = substitute(result, "%", "", "g")
        let result = substitute(result, ":", "", "g")
        let result = substitute(result, "[", "_", "g")
        let result = substitute(result, "]", "_", "g")
        let result = substitute(result, "+", "_", "g")
        let result = substitute(result, "-", "_", "g")
        return result
    catch /./
    endtry
endfunc

function! VsMax(fileName)
    call OpenOrSwitch(a:fileName, 'vs')
endfunc

function! RunShell(shell, ...)
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    let silent = substitute(system('git config vrun.silent'), '\n', '', '')
    let async = substitute(system('git config vrun.async'), '\n', '', '')
    let temp_log = arg2 . '.findresult'
    let run_string = a:shell . ' ' . '"' .  arg1 . '"' .  ' ' . '2>&1 | tee' . ' ' . temp_log

    if async ==? "true"
        call asyncrun#run('<bang>', '', ' ' . run_string)
    else
        if silent ==? "true"
            silent exec '!' . run_string
        else
            exec '!' . run_string
        endif
    endif
    silent exec '!cp' . ' -fv ' . '"' .  temp_log . '"' . ' ' . '"' .  arg2 . '"'
    silent exec '!~/loadrc/bashrc/removing_ansi_color_codes.sh' . ' ' . '"' .  arg2 . '"'
endfunc

function! Filter2FindResult()
    let worktree = Cd2Worktree()
    let keyword = @/
    let b:result = GetEscapedResult(keyword)

    if expand('%:e') != 'findresult'
        let buffername = b:result . '.findresult'

        " Save the current buffer content in a variable
        let buffer_content = join(getline(1, '$'), "\n")

        " Create or overwrite the buffer with the new content
        call writefile(split(buffer_content, "\n"), buffername)

        let worktree = Cd2Worktree()
        call OpenOrSwitch(buffername, 'vs')
    endif
endfunction

function! Cd2ProjectRoot(filename)
    let csdbpath = FindFileUpwards(a:filename, "/")
    exec "cd " . csdbpath
    return csdbpath
endfunc

function! Cd2Worktree()
    let worktree = GetGitWorkDirOrCurrentDir()

    try
        exec "cd " . fnameescape(worktree)
    catch /./
    endtry

    return worktree
endfunc

function! GetCurrentFileName()
    return '"' . expand("%:p") . '"'
endfunc

function! GetUnnamedRegister()
    return '"' . @" . '"'
endfunc

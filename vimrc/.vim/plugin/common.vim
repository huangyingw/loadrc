function! CHANGE_CURR_DIR()
    let _dir = expand("%:p:h")

    try
        exec "cd " . fnameescape(_dir)
    catch /.*/
        echom 'Cought anything: ' . v:exception
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
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            " 如果右括号是当前行最后一个字符
            execute "normal! v%xa"
        else
            " 如果右括号不是当前行最后一个字符
            execute "normal! v%xi"
        end

    else
        execute "normal! a\<BS>"
    end
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")] " 取得当前光标后一个字符

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    end
endfunction

function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 20m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 30m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 30m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
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
        normal! g`"
        return 1
    endif
endfunction

"==
" Find_in_parent
" find the file argument and returns the path to it.
" Starting with the current working dir, it walks up the parent folders
" until it finds the file, or it hits the stop dir.
" If it doesn't find it, it returns "Nothing"
function! Find_in_parent(fln, flsrt, flstp)
    let here = a:flsrt

    while ( strlen( here) > 0 )
        if filereadable( here . "/" . a:fln )
            return here
        elseif isdirectory( here . "/" . a:fln )
            return here
        endif

        let fr = match(here, "/[^/]*$")

        if fr == -1
            break
        endif

        let here = strpart(here, 0, fr)

        if here == a:flstp
            break
        endif
    endwhile

    return "Nothing"
endfunc

function! GetWorktree()
    return substitute(system("~/loadrc/gitrc/get_worktree.sh " . '"' . expand('%:p') . '"'), '\n', '', '')
endfunction

function! OpenOrSwitch(buffername, openMode)
    let bnr = bufwinnr(a:buffername)

    if bnr > 0
        exe bnr . "wincmd w"
    elseif a:openMode ==? "goto"
        silent exec 'e ' . a:buffername
    else
        silent exec 'vs ' . a:buffername
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
    let result = substitute(result, " ", "", "g")
    let result = substitute(result, "/", "", "g")
    let result = substitute(result, "|", "", "g")
    let result = substitute(result, "(", "", "g")
    let result = substitute(result, ")", "", "g")
    let result = substitute(result, '\"', '', 'g')
    let result = substitute(result, '\,', '', 'g')
    let result = substitute(result, '\\', '', 'g')
    let result = substitute(result, '\$', '', 'g')
    let result = substitute(result, '#', '', 'g')
    let result = substitute(result, '!', '\\!', 'g')
    return result
endfunc

function! VsMax(fileName)
    call OpenOrSwitch(a:fileName, 'vs')
endfunc

function! RunShell(shell, ...)
    let arg1 = (a:0 >= 1) ? a:1 : ''
    let arg2 = (a:0 >= 2) ? a:2 : ''
    let arg3 = (a:0 >= 3) ? a:3 : ''
    let silent = substitute(system('git config vrun.silent'), '\n', '', '')
    let async = substitute(system('git config vrun.async'), '\n', '', '')

    if async ==? "false"
        if silent ==? "false"
            exec '!' . a:shell . ' "' .  arg1 . '" "' .  arg2 . '" 2>&1 | tee ' . arg1 . '.findresult'
        else
            silent exec '!' . a:shell . ' "' .  arg1 . '" "' .  arg2 . '" 2>&1 | tee ' . arg1 . '.findresult'
        endif
    else
        call asyncrun#run('<bang>', '', 'bash ' . a:shell . ' "' .  arg1 . '" "' .  arg2 . '" 2>&1 | tee ' . arg1 . '.findresult')
    endif
endfunc

function! Filter2Findresult()
    let csdbpath = Find_in_parent("files.proj", Windowdir(), "/")
    let keyword = @/
    let b:result = GetEscapedResult(keyword)

    if expand('%:e') != "findresult"
        let buffername = csdbpath . '/' . b:result . '.vaa.findresult'
        silent exec '!rm ' . buffername

        if bufexists(buffername)
            exe "bd!" . buffername
        endif

        silent exec 'w! ' . buffername
        call OpenOrSwitch(buffername, 'vs')
    endif
endfunc

function! Cd2ProjectRoot(filename)
    let csdbpath = Find_in_parent(a:filename, Windowdir(), "/")

    if csdbpath != "Nothing"
        exec "cd " . csdbpath
        return csdbpath
    endif
endfunc

function! Cd2Worktree()
    let worktree = GetWorktree()
    exec "cd " . worktree
    return worktree
endfunc

function! RememberQuit()
    let @" = expand("%:p")

    if winbufnr(2) == -1 && &buftype !=# "terminal"
        return
    endif

    quit
endfunction

function! ExFilter()
    call Filter2FindResult()
    silent exec 'g/' . @/ . '/d'

    try
        w!
    catch
    endtry
endfunction

function! ExtractHighLight()
    call Filter2FindResult()
    silent exec '%s/.*\(' . @/ . '\).*/\1/g'
    w!
endfunction


function! Vdelete()
    call Filter2FindResult()
    silent exec '%s/' . @/ . '//g'
    w!
endfunction

if !exists('g:VeryLiteral')
    let g:VeryLiteral = 0
endif

function! HighlightKeyword(keyword)
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let @@ = a:keyword
    if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
        let @/ = '\c' . a:keyword
    else
        let pat = escape(@@, '\')
        if g:VeryLiteral
            let pat = substitute(pat, '\n', '\\n', 'g')
        else
            let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
            let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
            let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
            let pat = substitute(pat, '\\!', '!', 'g')
            let pat = substitute(pat, '\\"', '"', 'g')
        endif
        let @/ = '\c' . pat
    endif
    normal! gV
    call setreg('"', old_reg, old_regtype)
endfunction

function! VFilter()
    call Filter2FindResult()
    silent exec 'g!/' . @/ . '/d'

    try
        w!
    catch
    endtry
endfunction

function! ShowRemember()
    call Cd2ProjectRoot("files.proj")

    " echom relativePath
    call SendTextToPbCopy(expand('%:p'))

    if &clipboard == 'unnamed'
        let @* = expand('%:p')
    else
        let @+ = expand('%:p')
    endif
endfunction

function! Filter()
    let b:keyword = expand("<cword>")
    exec '%g!/' . b:keyword . '/d'
endfunction

function! PlayVideo(...) abort
    " Return early if the buffer type is a terminal
    if &buftype ==# "terminal"
        return 0
    endif

    " If no line argument is passed, use the current line
    if a:0 > 0
        let line = a:1
    else
        let line = getline('.')
    endif

    let line = getline('.')
    let line = substitute(line, '\_s\+$', '', 'g')
    let line = substitute(line, '^[^"]', '"' . line[0], '')
    let line = substitute(line, '[^"]$', line[strlen(line) - 1] . '"', '')
    let line = substitute(line, ",\"", ",", "")

    call AsyncRunShellCommand('~/loadrc/pythonrc/vlc.py ' . '"' . expand("%:p") . '"' .  ' ' . line)
endfunction

function! VDebug()
    if g:asyncrun_status ==# 'running'
        echom 'background job is still running'
        return 0
    endif

    let b:file_name = expand('%:t')
    let b:to_run = expand("%:p")

    if filereadable(b:to_run . '.sh')
        let b:to_run = b:to_run . '.sh'
    endif

    let b:csdbpath = Cd2ProjectRoot("files.proj")
    let b:output = b:csdbpath . '/' . b:file_name . '.runresult'
    call RunShell('~/loadrc/vishrc/vdebug.sh', b:to_run, b:output)

    if b:to_run != 'gbil.log'
        call OpenOrSwitch(b:output, 'vs')
    else
        call OpenOrSwitch('gbil.log', 'vs')
    endif
endfunction

function! VRun()
    if &modified
        echom 'Please check and save your file first!!!'
        return 1
    endif

    if g:asyncrun_status ==# 'running'
        echom 'background job is still running'
        return 0
    endif

    let b:file_name = expand('%:t')
    let b:to_run = expand("%:p")

    if (expand('%:e') ==# 'php')
        exec '!~/loadrc/imvurc/generate.sh ' . '"' .  expand('%:p') . '"'
    endif

    if filereadable(b:to_run . '.lsh')
        let b:to_run = b:to_run . '.lsh'
    elseif filereadable(b:to_run . '.sh')
        let b:to_run = b:to_run . '.sh'
    endif

    let b:csdbpath = Cd2Worktree()
    let b:output = b:csdbpath . '/' . b:file_name . '.runresult'
    silent exec '!~/loadrc/bashrc/deploy.sh 2>&1 | tee deploy.findresult'
    call RunShell('~/loadrc/vishrc/vrun.sh', b:to_run, b:output)

    if (expand("%") =~ '.*leetcode.*')
        call AsyncRunShellCommand('~/loadrc/leetcoderc/post_submit.sh ' . '"' .  b:file_name . '"' . ' 2>&1 | tee post_submit.log')
    endif

    if b:to_run != 'gbil.log'
        call OpenOrSwitch(b:output, 'vs', '')
    else
        call OpenOrSwitch('gbil.log', 'vs')
    endif

    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
endfunction

function! SearchAgain()
    call Cd2ProjectRoot('files.proj')
    let keyword = substitute(@/, '\\c', '', '')
    let keyword = substitute(keyword, '\\<', '', '')
    let keyword = substitute(keyword, '\\>', '', '')
    let b:result = GetEscapedResult(keyword)
    exec '!~/loadrc/vishrc/vsearch.sh ' . expand("%:p") . ' "' .  keyword . '"' . ' "w" ' . '"' . b:result . '"'
    call OpenOrSwitch(b:result . '.findresult', 'vs')
endfunction

function! GetFirstColumnOfFile()
    if (expand('%:e') ==# 'bak')
        return 0
    endif

    silent exec '!~/loadrc/bashrc/get_first_column_of_file.sh ' . '"' .  expand("%:p") . '"'
    call OpenOrSwitch(expand("%:p") . '.tmp', 'vs')
endfunction

function! CSCSearch(num)
    " 0 Find this C symbol:
    " 1 Find this function definition:
    " 2 Find functions called by this function:
    " 3 Find functions calling this function:
    " 4 Find this text string:
    " 5 Change this text string:
    " 6 Find this egrep pattern:
    " 7 Find this file:
    " 8 Find files #including this file:
    call Cd2ProjectRoot('files.proj')
    let keyword = tolower(expand("<cword>"))
    let b:result = GetEscapedResult(keyword)
    silent exec '!~/loadrc/vishrc/vsearch.sh ' . "files.proj" . ' "' .  keyword . '"' . ' "' .  a:num . '" ' . '"' . b:result . '"'
    call OpenOrSwitch(b:result . '.findresult', 'vs')
    set winwidth=999999
    call HighlightKeyword(keyword)
endfunction

function! SearchOpen()
    normal! gvy<CR>
    let keyword = @@
    call Cd2ProjectRoot("files.proj")
    let find_file = substitute(system("~/loadrc/gitrc/find_files.sh " . '"' .  keyword . '"'), '\n', '', '')
    call OpenOrSwitch(find_file, 'vs')
endfunction

function! ShowDiff()
    let b:commit = expand("<cword>")
    call AsyncRunShellCommand('~/loadrc/gitrc/gvlg.sh ' . '"' .  b:commit . '"')
endfunction

function! Prune()
    if (expand('%:e') ==# 'findresult' || expand('%:e') ==# 'bak')
        let line = getline('.')
        normal dd
        w
        silent exec '!~/loadrc/vishrc/prune.sh ' . '"./' .  line . '"'
    else
        silent exec '!~/loadrc/vishrc/prune.sh ' . '"' .  expand('%:p') . '"'
        call RememberQuit()
    endif
    call UpdateProj()
endfunction

function! OpenAll()
    call GetFirstColumnOfFile()
    let currentDir = getcwd()
    let currentFile = expand('%:p')
    let lines = readfile(currentFile)

    on
    for line in lines
        " Debug: Print line before substitution
        echo "Before substitution: " . line

        let line = substitute(line, '"', '', "g")

        " Debug: Print line after substitution
        echo "After substitution: " . line

        " Check if the line starts with "/"
        if line[0] == "/"
            let filePath = line
        else
            let filePath = currentDir . '/' . line
        endif

        " Debug: Print the final file path
        echo "Final file path: " . filePath

        if filereadable(filePath)
            exec 'vs ' . filePath
        else
            " Debug: Print if the file is not readable or doesn't exist
            echo "The file " . filePath . " is not readable or does not exist."
        endif
    endfor
    windo set nowrap
    " set winwidth=999999
    " wincmd |

    let bnr = bufwinnr('^' . currentFile . '$')
    exe bnr . "wincmd w"
    q
endfunction

function! DiffAll()
    let currentFile = expand("%:p")
    if &diff
        syntax on
        windo diffoff
    else
        set winwidth=1
        syntax off
        windo diffthis
        windo set nowrap
        wincmd =
    endif
    call OpenOrSwitch(currentFile, 'vs')
endfunction

function! KdiffAll()
    call GetFirstColumnOfFile()

    if &buftype ==# "terminal"
        return 0
    endif

    only
    call asyncrun#stop('<bang>')
    call AsyncRunShellCommand('~/loadrc/vishrc/kdiffall.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! UpdateProj()
    call Cd2ProjectRoot("files.proj")
    call AsyncRunShellCommand('~/loadrc/bashrc/update_proj.sh')
    call CHANGE_CURR_DIR()
endfunction

function! VimOpen()
    let b:fileName = expand(expand("<cfile>"))
    let b:filePath = fnamemodify(expand(expand("<cfile>")), ":p:h")

    if b:fileName =~? '\.\(pptx\|doc\|docx\)$'
        exec '!open ' . '"' .  b:fileName . '"'
        return
    endif

    if (expand("%") ==# 'index')
        let realFile = GetGitWorkDirOrCurrentDir() . '/' . b:fileName . ''
        let indexFile = getcwd() . '/../' . b:fileName . '/.git/index'
        let moduleIndexFile = getcwd() . '/modules/' . b:fileName . '/index'

        if filereadable(realFile)
            call OpenOrSwitch(realFile, 'vs')
        elseif filereadable(indexFile)
            call OpenOrSwitch(indexFile, 'vs')
        elseif filereadable(moduleIndexFile)
            call OpenOrSwitch(moduleIndexFile, 'vs')
        else
            call OpenOrSwitch(realFile, 'vs')
        endif
    elseif (expand("%") ==# 'gbr.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
    elseif (expand("%") ==# 'gbil.log')
        let b:commit = expand("<cword>")
        call Cd2Worktree()
        exec '!~/loadrc/gitrc/discard_unnecessaries.sh ; git checkout ' . '"' .  b:commit . '"'
    elseif (expand("%") ==# 'glg.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
    elseif (expand("%") ==# 'dps.findresult')
        let b:commit = expand("<cword>")
        call AsyncRunShellCommand('~/loadrc/dockerrc/edocker.sh ' . '"' .  b:commit . '"')
    elseif (expand("%") ==# 'fdocs.list')
        exec '!open ' . '"' .  expand(expand("<cfile>")) . '"'
    elseif (b:fileName =~ '.*.diff$')
        let b:commit = expand("<cword>")
        let output = b:commit . '.diff'

        if !filereadable(output)
            silent exec '!~/loadrc/gitrc/gshow.sh ' . '"' .  b:commit . '" 2>&1 | tee ' . output
        endif

        call OpenOrSwitch(b:fileName, 'vs')
    elseif (&filetype ==# 'fugitiveblame')
        let b:commit = expand("<cword>")
        call Cd2Worktree()
        exec '!~/loadrc/gitrc/discard_unnecessaries.sh ; git diff --quiet && git diff HEAD --quiet &&  git checkout -f ' . '"' .  b:commit . '^"'
        ""call fugitive#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", "' . 'blame' . ' " . <q-args>)
        "let s:cmd = 'Blame'
        "exec 'command! -bang -nargs=? -range=-1 -complete=customlist,fugitive#' . s:cmd . 'Complete G' . tolower(s:cmd) 'exe fugitive#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", "' . tolower(s:cmd) . ' " . <q-args>)'
        ""call fugitive#Gblame()
    else
        if !filereadable(b:fileName)
            if !isdirectory(b:filePath)
                call mkdir(b:filePath, "p")
            endif
        endif
        call OpenOrSwitch(b:fileName, 'vs')
    endif
endfunction

function! GitSearch()
    let keyword = substitute(@/, '\\c', '', '')
    let keyword = substitute(keyword, '\\<', '', '')
    let keyword = substitute(keyword, '\\>', '', '')
    let keyword = substitute(keyword, '\\V', '', '')
    let b:result = GetEscapedResult(keyword) . '.runresult'
    let fileList = expand('%:p')

    call Cd2Worktree()
    exec '!~/loadrc/gitrc/gsearch.sh ' . '"' .  keyword . '"' . ' "' .  b:result . '"' . ' ' . '"' .  fileList . '"'
    call OpenOrSwitch(b:result, 'vs')
    call HighlightKeyword(keyword)
endfunction

function! VimSearch()
    normal! gvy<CR>
    call Cd2ProjectRoot('files.proj')
    let keyword = GetEscapedKeyword(@@)
    let b:result = GetEscapedResult(keyword)
    exec '!~/loadrc/vishrc/vsearch.sh ' . "files.proj" . ' "' .  keyword . '"' . ' "w" ' . '"' . b:result . '"'
    call OpenOrSwitch(b:result . '.findresult', 'vs')
    exec 'e'
    call HighlightKeyword(keyword)
endfunction

function! SwitchWinSize()
    if &winwidth == 1
        set winwidth=999999
        wincmd |
    else
        set winwidth=1
        wincmd =
    endif
endfunction

nnoremap <leader>l :TlistClose<CR>:TlistToggle<cr>
nnoremap <leader>L :TlistClose<cr>
nnoremap hh <c-w>h
nnoremap ll <c-w>l
nnoremap mn :call SwitchWinSize()<cr>
nnoremap ff <c-f>
nnoremap vv <c-b>
nnoremap <c-l> l
nnoremap <c-h> h
" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>
" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>
" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
" nnoremap / /\v\c
" vnoremap / /\v\c
nnoremap / /\c
vnoremap / /\c
nnoremap ? ?\c
vnoremap ? ?\c
" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
nnoremap <Space> za
vnoremap <Space> za
"inoremap <silent> <leader>f <C-O>za
"nnoremap <silent> <leader>f za
"onoremap <silent> <leader>f <C-C>za
"vnoremap <silent> <leader>f zf
nnoremap <silent> <leader>e :call VsMax($HOME . "/.bash_history") <CR>
nnoremap <silent> <leader>f :call ShowRemember()<cr>
nnoremap <silent> <leader>v :so $MYVIMRC<cr>
nnoremap <leader>sh :execute "leftabove vs" bufname('#')<cr>
nnoremap <leader>sl :execute "rightbelow vs" bufname('#')<cr>
nnoremap W :call VsMax(".")<CR>
" Quickly reload current file
nnoremap E :mkview<CR>:e!<CR>
" Quickly save current file
nnoremap S :w!<cr>
" Quickly save and exit
nnoremap X :x<cr>
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap tt :Autoformat<CR>:w!<cr><cr>
nnoremap D :call OpenDup()<CR>
" Quickly open current dir in current windows
nnoremap <tab> %
vnoremap <tab> %
nnoremap M zM
nnoremap R zR
nmap <leader>w :call WinDo('set wrap!') <cr>

" nnoremap F :echom expand('%:p')<cr>
vnoremap <silent>f :call VimSearch()<cr>
vnoremap <silent>s :call GitSearch()<cr>
nnoremap mt :call SearchAgain()<cr>
nnoremap mc :set cursorline!<cr>
" nnoremap mc :set hlsearch!<cr>
nnoremap mg :call VFilter()<cr>
nnoremap me :call ExtractHighLight()<cr>
nnoremap mf :call ExFilter()<cr>
nnoremap md :call Vdelete()<cr>
nnoremap mo :call OpenAll()<cr>
vnoremap <silent>o :call SearchOpen()<cr>
vnoremap <silent>m :s/ //<CR>
nmap <C-s> :call CSCSearch(0)<cr>
nnoremap <c-space> :call CSCSearch(4)<cr>
nmap <C-@> :call CSCSearch(4)<cr>
nmap <C-f> :call CSCSearch(7)<cr>
nmap <C-e> :call CSCSearch(1)<cr>
nmap <C-g> :call CSCSearch(3)<cr>
nnoremap <leader>d :!rm "%:p"<CR>:q<cr>
nmap <C-j> :call PlayVideo()<cr>
nmap <C-p> :call Prune()<cr>
nmap <C-k> :call KdiffAll()<cr>
nmap <C-d> :call DiffAll()<cr>
nmap mr :call LocalRename()<cr>
" Quickly close the current window
nnoremap Q :call RememberQuit()<cr>
nnoremap qq :call RememberQuit()<cr>
nnoremap H :call ShowVITAG()<cr>
nnoremap F :call GetFirstColumnOfFile()<cr>
nnoremap T :vs $HOME/all.proj<cr>
nnoremap L :vs <C-R>"<cr>
nnoremap <leader>r :call Reverse()<cr>
map <F5> :call VRun()<cr><cr>
map <F3> :call VDebug()<cr>
" nnoremap gf gF<cr>
nnoremap gf :call OpenOrSwitch(expand(expand("<cfile>")), 'goto')<cr>
map oo :call VimOpen()<cr>
nnoremap <silent> <leader>g :call AsyncRunShellCommand('gitk --all -p --full-diff -- "' . expand("%:p") . '"')<cr>
nnoremap <leader>1 :let @" = expand("%:p")<CR>

function! CutFile2()
    silent exec '!comm -2 -3 <(sort "' . @" . '") <(sort "' . expand("%:p") . '") > "' . @" . '".findresult'
    silent exec '!cp -fv "' . @" . '.findresult' . '"' . ' ' . '"' . @" . '"'
    call OpenOrSwitch(@", 'vs')
endfunc

function! CutCommon()
    exec '!~/loadrc/bashrc/compare_unique_lines_sort.sh ' . '"' .  @" . '"'  . ' ' . '"' .  expand("%:p") . '"'
endfunc

nnoremap <leader>2 :call CutCommon()<cr>
nnoremap <leader>3 :call CutFile2()<cr>
set pastetoggle=<F3>            " when in insert mode, press <F3> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

" open tig with Project root path
nnoremap <Leader>t :TigOpenProjectRootDir<CR>
nnoremap <leader>T :TigOpenCurrentFile<CR>
nnoremap <silent> ml :call CopyLineInfo()<cr>

function! CopyLineInfo()
    normal yy
    let b:csdbpath = Cd2ProjectRoot("files.proj")
    let relativePath = expand('%:p')
    let relativePath = substitute(relativePath, b:csdbpath.'/', '', '')
    let relativePath = substitute(relativePath, '\_s', '\\ ', "g")
    let content = relativePath . ':' . line('.') . ' ' . @"
    let @" = content
endfunction

function! OpenDup()
    only
    let is_rej = 0

    if (expand('%:e') ==# 'rej')
        let is_rej = 1
        let to_open = substitute(expand('%:p'), '\.rej', '', '')
        silent exec 'vs ' . to_open
    else
        silent exec 'vs ' . expand("%:p") . '.bak'
    endif

    set winwidth=1
    wincmd =

    if (is_rej == 1)
        call DiffAll()
    endif
endfunction

function! Reverse()
    exec 'g/^/m0'
endfunction

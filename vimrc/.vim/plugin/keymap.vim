function! RememberQuit()
    let @"=expand("%:p")

    if winbufnr(2) == -1 && &buftype !=# "terminal"
        return
    endif

    quit
endfunction

function! ExFilter()
    call Filter2Findresult()
    silent exec 'g/' . @/ . '/d'
    w
endfunction

if !exists('g:VeryLiteral')
    let g:VeryLiteral = 0
endif

function! HighlightKeyword(keyword)
    let @@ = a:keyword
    if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
        let @/ = @@
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
        let @/ = '\V'.pat
    endif
endfunction

function! VFilter()
    call Filter2Findresult()
    silent exec 'g!/' . @/ . '/d'
    w
endfunction

function! ShowRemember()
    let @+=expand('%:p')
    echom expand('%:p')
endfunction

function! Filter()
    let b:keyword = expand("<cword>")
    exec '%g!/' . b:keyword . '/d'
endfunction

function! PlayVideo()
    if &buftype ==# "terminal"
        return 0
    endif

    call asyncrun#stop('<bang>')
    call RunShell('~/loadrc/vishrc/vlc.sh', expand("%:p"))
endfunction

function! VDebug()
    let b:csdbpath = Find_in_parent("files.proj", Windowdir(), "/")
    call RunShell('~/loadrc/vishrc/vdebug.sh', expand("%:p"), b:csdbpath)
    call OpenOrSwitch('"' . expand("%:p") . '"' . '.findresult', 'vs')
endfunction

function! VRun()
    if g:asyncrun_status ==# 'running'
        echom 'background job is still running'
        return 0
    endif

    if filereadable(expand("%:p") . '.sh')
        call OpenOrSwitch(expand("%:p") . '.sh', 'vs')
        return 0
    endif

    let b:csdbpath = Find_in_parent("files.proj", Windowdir(), "/")
    call RunShell('~/loadrc/vishrc/vrun.sh', expand("%:p"), b:csdbpath)
    call OpenOrSwitch(expand("%:p") . '.findresult', 'vs')
endfunction

function! SearchAgain()
    call Cd2ProjectRoot('files.proj')
    let keyword = @/
    let b:result = GetEscapedResult(keyword)
    silent exec '!~/loadrc/vishrc/vsearch.sh ' . expand("%:p") . ' "' .  keyword . '"' . ' "w" ' . '"' . b:result . '"'
    call OpenOrSwitch(b:result . '.findresult', 'vs')
endfunction

function! GetFirstColumnOfFile()
    let bak_file = substitute(system('~/loadrc/bashrc/get_first_column_of_file.sh ' . '"' .  expand("%:p") . '"'), '\n', '', '')
    silent exec '!~/loadrc/bashrc/get_first_column_of_file.sh ' . '"' .  expand("%:p") . '"'
    call OpenOrSwitch(expand("%:p") . '.bak', 'vs')
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
    let keyword = expand("<cword>")
    let b:result = GetEscapedResult(keyword)
    silent exec '!~/loadrc/vishrc/vsearch.sh ' . "files.proj" . ' "' .  keyword . '"' . ' "' .  a:num . '" ' . '"' . b:result . '"'
    call OpenOrSwitch(b:result . '.findresult', 'vs')
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
    call asyncrun#run('<bang>', '', 'bash ~/loadrc/gitrc/gvlg.sh ' . '"' .  b:commit . '"')
endfunction

function! Prune()
    if (expand('%:e') ==# 'findresult' || expand('%:e') ==# 'bak')
        let line = getline('.')
        normal dd
        w
        silent exec '!~/loadrc/vishrc/prune.sh ' . '"./' .  line . '"'
    else
        silent exec '!~/loadrc/vishrc/prune.sh ' . '"' .  expand('%:p') . '"'
    endif
endfunction

function! KdiffAll()
    if &buftype ==# "terminal"
        return 0
    endif

    call asyncrun#stop('<bang>')
    call asyncrun#run('<bang>', '', 'bash ~/loadrc/vishrc/kdiffall.sh ' . '"' .  expand('%:p') . '"')
endfunction

function! UpdateProj()
    call Cd2ProjectRoot("files.proj")
    call asyncrun#run('<bang>', '', 'bash ~/loadrc/bashrc/update_proj.sh')
endfunction

function! VimOpen()
    let b:fileName = expand(expand("<cfile>"))
    let b:filePath = fnamemodify(expand(expand("<cfile>")), ":p:h")
    if (expand("%") ==# 'index')
        let realFile = GetWorktree() . '/' . b:fileName . ''
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
    elseif (expand("%") ==# 'gbil.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
    elseif (expand("%") ==# 'glg.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
    elseif (expand("%") ==# 'dps.findresult')
        let b:commit = expand("<cword>")
        call asyncrun#run('<bang>', '', 'bash ~/loadrc/dockerrc/edocker.sh ' . '"' .  b:commit . '"')
    elseif (&filetype ==# 'fugitiveblame')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '^"'
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
    normal! gvy<CR>
    let keyword = GetEscapedKeyword(@@)
    let b:result = GetEscapedResult(keyword)

    call Cd2Worktree()
    silent exec '!~/loadrc/gitrc/gsearch.sh ' . '"' .  keyword . '"' . ' "' .  b:result . '"'
    call OpenOrSwitch(b:result . '.gsearch.findresult', 'vs')
    call HighlightKeyword(keyword)
endfunction

function! VimSearch()
    normal! gvy<CR>
    call Cd2ProjectRoot('files.proj')
    let keyword = GetEscapedKeyword(@@)
    let b:result = GetEscapedResult(keyword)
    silent exec '!~/loadrc/vishrc/vsearch.sh ' . "files.proj" . ' "' .  keyword . '"' . ' "w" ' . '"' . b:result . '"'
    call OpenOrSwitch(b:result . '.findresult', 'vs')
    exec 'e'
    call HighlightKeyword(keyword)
endfunction

function! OpenProjectRoot()
    let b:csdbpath = Find_in_parent("files.proj", Windowdir(), "/")
    let @+=b:csdbpath
    echom b:csdbpath
    call OpenOrSwitch(b:csdbpath, 'vs')
endfunction

nnoremap <leader>l :TlistClose<CR>:TlistToggle<CR><CR>
nnoremap <leader>L :TlistClose<CR><CR>
nnoremap hh <c-w>h<c-w><Bar>
nnoremap ll <c-w>l<c-w><Bar>
nnoremap mm <c-w><Bar>
nnoremap mn <c-w>=
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
nnoremap <silent> <leader>f :call ShowRemember()<CR><CR>
nnoremap <silent> <leader>v :so $MYVIMRC<CR><CR>
nnoremap <leader>sh :execute "leftabove vs" bufname('#')<cr><CR>
nnoremap <leader>sl :execute "rightbelow vs" bufname('#')<cr><CR>
nnoremap W :call VsMax(".")<CR>
" Quickly reload current file
nnoremap E :mkview<CR>:e!<CR>
" Quickly save current file
nnoremap S :w<CR><CR>
" Quickly save and exit
nnoremap X :x<CR><CR>
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap tt :Autoformat<CR>:w<CR><CR>
nnoremap D :vs %:p<CR><CR>
" Quickly open current dir in current windows
nnoremap <leader>d :call OpenProjectRoot()<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap M zM
nnoremap R zR
nmap <f2> :set number! number?<cr>
nmap <leader>w :set wrap!<cr>
" Convert slashes to backslashes for Windows.
if has('win32')
    nmap <leader>cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
    nmap <leader>cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

    " This will copy the path in 8.3 short format, for DOS and Windows 9x
    nmap <leader>c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
    nmap <leader>cs :let @*=expand("%")<CR>
    nmap <leader>cl :let @*=expand("%:p")<CR>
endif
if has('win32')
    nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
    nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

    " This will copy the path in 8.3 short format, for DOS and Windows 9x
    nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
    nmap fs :let @"=expand("%")<CR>
    nmap <leader>p :let @"=expand("%:p")<CR>
endif
" nnoremap F :echom expand('%:p')<cr>
vnoremap <silent>f :call VimSearch()<cr>
vnoremap <silent>s :call GitSearch()<cr>
vnoremap <silent>t :call SearchAgain()<cr>
vnoremap <silent>g :call VFilter()<cr>
vnoremap <silent>i :call ExFilter()<cr>
vnoremap <silent>o :call SearchOpen()<cr>
nmap <C-s> :call CSCSearch(0)<CR><CR>
nnoremap <c-space> :call CSCSearch(4)<CR><CR>
nmap <C-@> :call CSCSearch(4)<CR><CR>
nmap <C-f> :call CSCSearch(7)<CR><CR>
nmap <C-e> :call CSCSearch(1)<CR><CR>
nmap <C-g> :call CSCSearch(3)<CR><CR>
nnoremap <leader>d :!rm %:p<CR>:q<CR><CR>
nmap <C-j> :call PlayVideo()<CR><CR>
nmap <C-p> :call Prune()<CR><CR>
nmap <C-k> :call KdiffAll()<CR><CR>
" Quickly close the current window
nnoremap Q :call RememberQuit()<cr>
nnoremap qq :call RememberQuit()<cr>
nnoremap H :call ShowVITAG()<cr>
nnoremap F :call GetFirstColumnOfFile()<cr>
nnoremap T :vs $HOME/all.proj<CR><CR>
nnoremap L :vs <C-R>"<CR><CR>
map <F5> :call VRun()<cr>
map <F3> :call VDebug()<cr>
" nnoremap gf gF<CR><CR>
nnoremap gf :call OpenOrSwitch(expand(expand("<cfile>")), 'goto')<CR><CR>
map oo :call VimOpen()<cr>
nnoremap <silent> <leader>g :call asyncrun#run('<bang>', '', 'gitk --all -p --full-diff -- "' . expand("%:p") . '"')<CR><CR>
nnoremap <leader>1 :let @"=expand("%:p")<CR>

function! CompareTwoFiles()
    call asyncrun#run('<bang>', '', 'kdiff3 "' . @" . '" "' . expand("%:p") . '"')
endfunc

function! CommTwoFiles()
    silent exec '!comm -2 -3 <(sort "' . @" . '") <(sort "' . expand("%:p") . '") > "' . @" . '".findresult'
    call OpenOrSwitch(@" . '.findresult', 'vs')
endfunc

nnoremap <leader>2 :call CompareTwoFiles()<cr>
nnoremap <leader>3 :call CommTwoFiles()<cr>
nnoremap <leader>c :call UpdateProj()<cr>
set pastetoggle=<F3>            " when in insert mode, press <F3> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

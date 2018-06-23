function! RememberQuit()
    if (expand("%") ==# 'files.proj')
        return
    endif
    let @"=expand("%:p")
    if winbufnr(2) != -1
        quit
    endif
    vert resize
endfunction

function! ExFilter()
    normal! gvy<CR>
    let csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let keyword = @@
    let b:result = GetEscapedResult(keyword)
    let keyword = GetEscapedKeywordForVIM(keyword)
    echom 'keyword : '.keyword

    if expand('%:e') != "findresult"
        silent exec '!rm ' . csdbpath . '/' . b:result . '.vaa.findresult'
        silent exec 'w! ' . csdbpath . '/' . b:result . '.vaa.findresult'
        call OpenOrSwitch(csdbpath . '/' . b:result . '.vaa.findresult')
    endif

    silent exec 'g/\c' . keyword . '/d'
    w
    vert resize
endfunction
function! VFilter()
    normal! gvy<CR>
    let csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let keyword = @@
    let b:result = GetEscapedResult(keyword)
    let keyword = GetEscapedKeywordForVIM(keyword)
    echom 'keyword : '.keyword

    if expand('%:e') != "findresult"
        silent exec '!rm ' . csdbpath . '/' . b:result . '.vaa.findresult'
        silent exec 'w! ' . csdbpath . '/' . b:result . '.vaa.findresult'
        call OpenOrSwitch(csdbpath . '/' . b:result . '.vaa.findresult')
    endif

    silent exec 'g!/\c' . keyword . '/d'
    w
    vert resize
endfunction
function! ShowRemember()
    let @+=expand('%:p')
    echom expand('%:p')
endfunction
function! Filter()
    let b:keyword = expand("<cword>")
    exec '%g!/' . b:keyword . '/d'
    vert resize
endfunction
function! PlayAV()
    let line=getline('.')
    silent exec '!/Applications/VLC.app/Contents/MacOS/VLC ' . '"' .  line . '"'
    vert resize
endfunction
function! CSCSearchQ()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let keyword = expand("<cword>")
    silent exec '!~/loadrc/vishrc/vsearch.sh ' . b:csdbpath . ' ' .  keyword . ' ' . 1 . ' ' . 'qcsc'
    call OpenOrSwitch(b:csdbpath . '/' . keyword . '.qcsc.findresult')
endfunction
function! VDebug()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let silent = substitute(system('git config vrun.silent'), '\n', '', '')
    if silent ==? "false"
        exec '!~/loadrc/vishrc/vdebug.sh ' . expand("%:p") . ' ' . b:csdbpath
    else
        silent exec '!~/loadrc/vishrc/vdebug.sh ' . expand("%:p") . ' ' . b:csdbpath
    endif
    call OpenOrSwitch(expand("%:p") . '.findresult')
endfunction
function! VRun()
    if filereadable(expand("%:p") . '.sh')
        call OpenOrSwitch(expand("%:p") . '.sh')
        return 0
    endif
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let silent = substitute(system('git config vrun.silent'), '\n', '', '')
    if silent ==? "false"
        exec '!~/loadrc/vishrc/vrun.sh ' . expand("%:p") . ' ' . b:csdbpath
    else
        silent exec '!~/loadrc/vishrc/vrun.sh ' . expand("%:p") . ' ' . b:csdbpath
    endif
    call OpenOrSwitch(expand("%:p") . '.findresult')
endfunction
function! CSCSearch()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let keyword = expand("<cword>")
    silent exec '!~/loadrc/vishrc/vsearch.sh ' . b:csdbpath . ' ' .  keyword . ' ' . 4 . ' ' . 'csc'
    call OpenOrSwitch(b:csdbpath . '/' . keyword . '.csc.findresult')
    exec 'e'
    vert resize
    let @@ = keyword
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
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
        endif
        let @/ = '\V'.pat
    endif
    normal! gV
    call setreg('"', old_reg, old_regtype)
endfunction
function! SearchOpen()
    normal! gvy<CR>
    let b:keyword = @@
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    exec "cd " . b:csdbpath
    let find_file = substitute(system("~/loadrc/gitrc/find_files.sh " . '"' .  b:keyword . '"'), '\n', '', '')
    call OpenOrSwitch(find_file)
endfunction
function! ShowDiff()
    let b:commit = expand("<cword>")
    silent exec '!~/loadrc/gitrc/gvlg.sh ' . '"' .  b:commit . '"'
    vert resize
endfunction
function! Prune()
    silent exec '!~/loadrc/vishrc/prune.sh ' . '"' .  expand('%:p') . '"'
endfunction
function! UpdateCscope()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    silent exec '!~/loadrc/bashrc/cscope.sh ' . b:csdbpath
    vert resize
endfunction
function! VimOpen()
    let b:fileName = expand(expand("<cfile>"))
    let b:filePath = fnamemodify(expand(expand("<cfile>")), ":p:h")
    if (expand("%") ==# 'index')
        let worktree = substitute(system("~/loadrc/gitrc/get_worktree.sh " . expand('%:p')), '\n', '', '')
        let realFile = worktree . '/' . b:fileName
        let indexFile = getcwd() . '/modules/' . b:fileName . '/index'
        if filereadable(realFile)
            call OpenOrSwitch(realFile)
        elseif filereadable(indexFile)
            call OpenOrSwitch(indexFile)
        else
            call OpenOrSwitch(realFile)
        endif
    elseif (expand("%") ==# 'gbr.findresult')
        let b:commit = expand("<cword>")
        silent exec '!git checkout ' . '"' .  b:commit . '"'
        vert resize
    elseif (expand("%") ==# 'gbil.findresult')
        let b:commit = expand("<cword>")
        silent exec '!git checkout ' . '"' .  b:commit . '"'
        vert resize
    elseif (expand("%") ==# 'glg.findresult')
        let b:commit = expand("<cword>")
        silent exec '!git checkout ' . '"' .  b:commit . '"'
        vert resize
    elseif (expand("%") ==# 'dps.findresult')
        let b:commit = expand("<cword>")
        silent exec '!~/loadrc/dockerrc/edocker.sh ' . '"' .  b:commit . '"'
        vert resize
    else
        if !filereadable(b:fileName)
            if !isdirectory(b:filePath)
                call mkdir(b:filePath, "p")
            endif
        endif
        call OpenOrSwitch(b:fileName)
    endif
    vert resize
endfunction
function! GitSearch()
    normal! gvy<CR>
    let b:csdbpath = Find_in_parent(".git",Windowdir(),$HOME)
    let b:keyword = GetEscapedKeyword(@@)
    let b:result = GetEscapedResult(b:keyword)
    exec "cd " . b:csdbpath
    silent exec '!~/loadrc/gitrc/gsearch.sh ' . '"' .  b:keyword . '"' . ' "' .  b:result . '"'
    call OpenOrSwitch(b:result . '.gsearch.findresult')
endfunction
function! VimSearch()
    normal! gvy<CR>
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let b:keyword = GetEscapedKeyword(@@)
    let b:result = GetEscapedResult(b:keyword)
    silent exec '!~/loadrc/vishrc/vaa.sh ' . b:csdbpath . ' "' .  b:keyword . '"' . ' "' .  b:result . '"'
    call OpenOrSwitch(b:csdbpath.'/'.b:result.'.vaa.findresult')
    exec 'e'
    vert resize
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
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
        endif
        let @/ = '\V'.pat
    endif
    normal! gV
    call setreg('"', old_reg, old_regtype)
endfunction
function! OpenProjectRoot()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let @+=b:csdbpath
    echom b:csdbpath
    call OpenOrSwitch(b:csdbpath)
endfunction
function! FindCalling()
    let b:csdbpath = Find_in_parent("files.proj",Windowdir(),"/")
    let b:keyword = expand('%:t')
    silent exec '!~/loadrc/vishrc/vaa.sh ' . b:csdbpath . ' "' .  b:keyword . '"'
    let b:keyword = GetEscapedKeyword(b:keyword)
    call OpenOrSwitch(b:csdbpath . '/' . b:keyword . '.vaa.findresult')
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
nnoremap <leader>sh :execute "leftabove vs" bufname('#')<cr>:vert resize<CR><CR>
nnoremap <leader>sl :execute "rightbelow vs" bufname('#')<cr>:vert resize<CR><CR>
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
nnoremap D :vs %:p<CR>:vert resize<CR><CR>
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
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
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
nnoremap F :call FindCalling()<cr>
vnoremap <silent>f :call VimSearch()<cr>
vnoremap <silent>t :call GitSearch()<cr>
vnoremap <silent>g :call VFilter()<cr>
vnoremap <silent>i :call ExFilter()<cr>
vnoremap <silent>o :call SearchOpen()<cr>
nmap <C-@> :call CSCSearch()<CR><CR>
nmap <silent> <C-d> :!rm %:p<CR>:q<CR><CR>
" nmap <C-j> :call PlayAV()<CR><CR>
nmap <C-p> :call Prune()<CR><CR>
" Quickly close the current window
nnoremap Q :call RememberQuit()<cr>
nnoremap H :call ShowVITAG()<cr>
nnoremap T :vs $HOME/files.proj<CR>:vert resize<CR><CR>
map <F5> :call VRun()<cr>
map <F3> :call VDebug()<cr>
nnoremap gf gF<CR>:vert resize<CR><CR>
map oo :call VimOpen()<cr>
nnoremap <silent> <leader>g :!gitk --all -p --full-diff -- %:p<CR>:vert resize<CR><CR>
nnoremap <leader>1 :let @"=expand("%:p")<CR>

function! CompareTwoFiles()
    execute '!kdiff3' @" expand("%:p")
endfunc

nnoremap <leader>2 :call CompareTwoFiles()<cr>
nnoremap <leader>c :call UpdateCscope()<cr>
set pastetoggle=<F3>            " when in insert mode, press <F3> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

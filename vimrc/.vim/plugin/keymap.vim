function! RememberQuit()
    let @"=expand("%:p")
    q
    vert resize
endfunction

function! ExFilter()
    normal! gvy<CR>
    let csdbpath = Find_in_parent("cscope.out",Windowdir(),"/")
    let keyword = @@
    let b:result = GetEscapedResult(keyword)
    let keyword = GetEscapedKeywordForVIM(keyword)
    echom 'keyword : '.keyword

    if expand('%:e') != "findresult"
        exec 'w! ' . csdbpath . '/' . b:result . '.vaa.findresult'
        exec 'vs ' . csdbpath . '/' . b:result . '.vaa.findresult'
    endif

    exec 'g/' . keyword . '/d'
    w
    vert resize
endfunction
function! VFilter()
    normal! gvy<CR>
    let csdbpath = Find_in_parent("cscope.out",Windowdir(),"/")
    let keyword = @@
    let b:result = GetEscapedResult(keyword)
    let keyword = GetEscapedKeywordForVIM(keyword)
    echom 'keyword : '.keyword

    if expand('%:e') != "findresult"
        exec 'w! ' . csdbpath . '/' . b:result . '.vaa.findresult'
        exec 'vs ' . csdbpath . '/' . b:result . '.vaa.findresult'
    endif

    exec '%g!/' . keyword . '/d'
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
    exec '!/Applications/VLC.app/Contents/MacOS/VLC ' . '"' .  line . '"'
    vert resize
endfunction
function! CSCSearchQ()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    let b:keyword = expand("<cword>")
    exec '!~/loadrc/vishrc/vsearch.sh ' . b:csdbpath . ' ' .  b:keyword . ' ' . 1 . ' ' . 'qcsc'
    exec 'vs ' . b:csdbpath . '/' . b:keyword . '.qcsc.findresult'
    vert resize
endfunction
function! VDebug()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    exec '!~/loadrc/vishrc/vdebug.sh ' . expand("%:p") . ' ' . b:csdbpath
    vert resize
endfunction
function! VRun()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    exec '!~/loadrc/vishrc/vrun.sh ' . expand("%:p") . ' ' . b:csdbpath
    vert resize
endfunction
function! CSCSearch()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    let keyword = expand("<cword>")
    exec '!~/loadrc/vishrc/vsearch.sh ' . b:csdbpath . ' ' .  keyword . ' ' . 4 . ' ' . 'csc'
    exec 'vs ' . b:csdbpath . '/' . keyword . '.csc.findresult'
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
function! UpCscope()
    normal! gvy<CR>
    let b:keyword = @@
    exec '!touch ' . b:keyword . '/cscope.out'
    exec '!~/loadrc/bashrc/cscope.sh ' . b:keyword
    vert resize
endfunction
function! ShowDiff()
    let b:commit = expand("<cword>")
    exec '!~/loadrc/gitrc/gvlg.sh ' . '"' .  b:commit . '"'
    vert resize
endfunction
function! UpdateCscope()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    exec '!~/loadrc/bashrc/cscope.sh ' . b:csdbpath
    vert resize
endfunction
function! VimOpen()
    let b:fileName = expand(expand("<cfile>"))
    let b:filePath = fnamemodify(expand(expand("<cfile>")), ":p:h")
    if (expand("%") ==# 'index')
        if isdirectory(getcwd() . '/../' . b:fileName)
            exec 'vs ' . getcwd() . '/../' . b:fileName . '/.git/index'
        else
            vert wincmd F
        endif
    elseif (expand("%") ==# 'gbr.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
        vert resize
    elseif (expand("%") ==# 'gbil.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
        vert resize
    elseif (expand("%") ==# 'glg.findresult')
        let b:commit = expand("<cword>")
        exec '!git checkout ' . '"' .  b:commit . '"'
        vert resize
    elseif (expand("%") ==# 'dps.findresult')
        let b:commit = expand("<cword>")
        exec '!~/loadrc/dockerrc/edocker.sh ' . '"' .  b:commit . '"'
        vert resize
    else
        if !filereadable(b:fileName)
            if !isdirectory(b:filePath)
                call mkdir(b:filePath, "p")
            endif
            exec 'vs ' . b:fileName
            vert resize
        else
            vert wincmd F
        endif
    endif
    vert resize
endfunction
function! GitSearch()
    normal! gvy<CR>
    let b:csdbpath = Find_in_parent(".git/config",Windowdir(),$HOME)
    let b:keyword = @@
    exec "cd " . b:csdbpath
    exec '!~/loadrc/gitrc/gsearch.sh ' . '"' .  b:keyword . '"'
    let b:keyword = GetEscapedKeyword(b:keyword)
    exec 'vs ' . b:keyword . '.gsearch.findresult'
    vert resize
endfunction
function! VimSearch()
    normal! gvy<CR>
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),"/")
    let b:keyword = GetEscapedKeyword(@@)
    let b:result = GetEscapedResult(b:keyword)
    exec '!~/loadrc/vishrc/vaa.sh ' . b:csdbpath . ' "' .  b:keyword . '"' . ' "' .  b:result . '"'
    exec 'vs ' . b:csdbpath.'/'.b:result.'.vaa.findresult'
    exec 'w! ' . expand('%:p')
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
function! ShowProjectRoot()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),$HOME)
    let @+=b:csdbpath
    echom b:csdbpath
endfunction
function! FindCalling()
    let b:csdbpath = Find_in_parent("cscope.out",Windowdir(),"/")
    let b:keyword = expand('%:t')
    exec '!~/loadrc/vishrc/vaa.sh ' . b:csdbpath . ' "' .  b:keyword . '"'
    let b:keyword = GetEscapedKeyword(b:keyword)
    exec 'vs ' . b:csdbpath . '/' . b:keyword . '.vaa.findresult'
endfunction
nnoremap <leader>l :TlistClose<CR>:TlistToggle<CR>
nnoremap <leader>L :TlistClose<CR>
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
nnoremap <silent> <leader>v :so $MYVIMRC<CR>
nnoremap <leader>sh :execute "leftabove vs" bufname('#')<cr>:vert resize<CR>
nnoremap <leader>sl :execute "rightbelow vs" bufname('#')<cr>:vert resize<CR>
nnoremap W :call VsMax(".")<CR>
" Quickly reload current file
nnoremap E :mkview<CR>:e!<CR>
" Quickly save current file
nnoremap S :w<CR>
" Quickly save and exit
nnoremap X :x<CR>
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap tt :Autoformat<CR>:w<CR>
nnoremap D :vs %:p<CR>:vert resize<CR>
" Quickly open current dir in current windows
nnoremap <leader>d :call ShowProjectRoot()<cr>
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
" vnoremap <silent>g :call GitSearch()<cr>
vnoremap <silent>g :call VFilter()<cr>
vnoremap <silent>i :call ExFilter()<cr>
vnoremap <silent>o :call UpCscope()<cr>
nmap <C-@> :call CSCSearch()<CR><CR>
nmap <C-d> :call ShowDiff()<CR><CR>
nmap <C-f> :call CSCSearchQ()<CR><CR>
" nmap <C-j> :call PlayAV()<CR><CR>
" Quickly close the current window
nnoremap Q :call RememberQuit()<cr>
nnoremap H :call ShowVITAG()<cr>
nnoremap T :vs $HOME/files.proj<CR>:vert resize<CR>
nnoremap L :vs <C-R>"<CR>:vert resize<CR>
map <F5> :call VRun()<cr>
map <F3> :call VDebug()<cr>
nnoremap gf gF<CR>:vert resize<CR>
map oo :call VimOpen()<cr>
nnoremap <silent> <leader>g :!gitk --all -p --full-diff -- %:p<CR>:vert resize<CR>
nnoremap <leader>1 :let @"=expand("%:p")<CR>

function! CompareTwoFiles()
    execute '!kdiff3' @" expand("%:p")
endfunc

nnoremap <leader>2 :call CompareTwoFiles()<cr>
nnoremap <leader>c :call UpdateCscope()<cr>
set pastetoggle=<F3>            " when in insert mode, press <F3> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

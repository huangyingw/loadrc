function! RememberQuit()
  let @"=expand("%:p")
  q
  vert resize
endfunction

"==
" windowdir
"  Gets the directory for the file in the current window
"  Or the current working dir if there isn't one for the window.
"  Use tr to allow that other OS paths, too
function s:windowdir()
  if winbufnr(0) == -1
    let unislash = getcwd()
  else
    let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')
  endif
  return tr(unislash, '\', '/')
endfunc
"
"==
" Find_in_parent
" find the file argument and returns the path to it.
" Starting with the current working dir, it walks up the parent folders
" until it finds the file, or it hits the stop dir.
" If it doesn't find it, it returns "Nothing"
function s:Find_in_parent(fln,flsrt,flstp)
  let here = a:flsrt
  while ( strlen( here) > 0 )
    if filereadable( here . "/" . a:fln )
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
  return "/"
endfunc
function! PlayAV()
  let line=getline('.')
  exec '!/Applications/VLC.app/Contents/MacOS/VLC ' . '"' .  line . '"'
  vert resize
endfunction
function! CSCSearchQ()
  let b:csdbpath = <SID>Find_in_parent("cscope.out",<SID>windowdir(),$HOME)
  let b:keyword = expand("<cword>")
  exec '!~/loadrc/vishrc/vsearch.sh ' . b:csdbpath . ' ' .  b:keyword . ' ' . 1 . ' ' . 'qcsc'
  exec 'vs ' . b:csdbpath . '/' . b:keyword . '.qcsc.findresult'
  vert resize
endfunction
function! VRun()
  let b:csdbpath = <SID>Find_in_parent("cscope.out",<SID>windowdir(),$HOME)
  exec '!~/loadrc/vishrc/vrun.sh ' . expand("%:p") . ' ' . b:csdbpath
  vert resize
endfunction
function! CSCSearch()
  let b:csdbpath = <SID>Find_in_parent("cscope.out",<SID>windowdir(),$HOME)
  let b:keyword = expand("<cword>")
  exec '!~/loadrc/vishrc/vsearch.sh ' . b:csdbpath . ' ' .  b:keyword . ' ' . 4 . ' ' . 'csc'
  exec 'vs ' . b:csdbpath . '/' . b:keyword . '.csc.findresult'
  vert resize
endfunction
function! UpdateCscope()
  let b:csdbpath = <SID>Find_in_parent("cscope.out",<SID>windowdir(),$HOME)
  exec '!~/loadrc/bashrc/cscope.sh ' . b:csdbpath
  vert resize
endfunction
function! VimSearch()
  normal! gvy<CR>
  let b:csdbpath = <SID>Find_in_parent("cscope.out",s:windowdir(),"/")
  let b:keyword = @@
  exec '!~/loadrc/vishrc/vaa.sh ' . b:csdbpath . ' "' .  b:keyword . '"'
  let b:keyword = substitute(b:keyword, " ", "_", "g")
  let b:keyword = substitute(b:keyword, "/", "_", "g")
  exec 'vs ' . b:csdbpath . '/' . b:keyword . '.vaa.findresult'
  vert resize
endfunction
function! ShowProjectRoot()
  let b:csdbpath = <SID>Find_in_parent("cscope.out",<SID>windowdir(),$HOME)
  let @+=b:csdbpath
  echom b:csdbpath
endfunction
function! ShowRemember()
  let @+=expand('%:p')
  echom expand('%:p')
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
nnoremap <silent> <leader>e :vs $HOME/.bash_history<CR>:vert resize<CR>
nnoremap <silent> <leader>f :vs $HOME/loadrc/.loadrc<CR>:vert resize<CR>
nnoremap <silent> <leader>v :so $MYVIMRC<CR>
nnoremap <leader>sh :execute "leftabove vs" bufname('#')<cr>:vert resize<CR>
nnoremap <leader>sl :execute "rightbelow vs" bufname('#')<cr>:vert resize<CR>
nnoremap W :vs .<CR>:vert resize<CR>
" Quickly reload current file
nnoremap E :mkview<CR>:e!<CR>
" Quickly save current file
nnoremap S :w<CR>
" Quickly save and exit
nnoremap X :x<CR>
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap tt :Autoformat<CR>
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
nnoremap F :call ShowRemember()<cr>
vnoremap <silent>f :call VimSearch()<cr>
nmap <C-@> :call CSCSearch()<CR><CR>
nmap <C-f> :call CSCSearchQ()<CR><CR>
" nmap <C-j> :call PlayAV()<CR><CR>
" Quickly close the current window
nnoremap Q :call RememberQuit()<cr>
nnoremap H :call ShowVITAG()<cr>
nnoremap T :vs $HOME/cscope.findresult<CR>:vert resize<CR>
nnoremap L :vs <C-R>"<CR>:vert resize<CR>
map <F5> :call VRun()<cr>
nnoremap gf gF<CR>:vert resize<CR>
map oo :vert wincmd F<CR>:vert resize<CR>
nmap <C-g> :exec '!~/loadrc/gitrc/gsh.sh ' . expand("%:p")<CR>
nnoremap <silent> <leader>g :!gitk %:p<CR>:vert resize<CR> 
nnoremap <leader>1 :let @"=expand("%:p")<CR>

function! CompareTwoFiles()
  execute '!kdiff3' @" expand("%:p")
endfunc

nnoremap <leader>2 :call CompareTwoFiles()<cr>
nnoremap <leader>c :call UpdateCscope()<cr>
set pastetoggle=<F3>            " when in insert mode, press <F3> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

set helplang=cn
set encoding=utf8
set fileencodings=utf8,gbk,big5

set backupdir=~/.vimswaps,/tmp
syntax on
filetype plugin on
" Change the mapleader from \ to ,
let mapleader=","
let maplocalleader="\\"
filetype indent on

function! CHANGE_CURR_DIR()
  let _dir = expand("%:p:h")
  exec "cd " . fnameescape(_dir)
  unlet _dir
  if filereadable(".vimdc")
    source .vimdc
  endif
endfunction

autocmd BufEnter * call CHANGE_CURR_DIR()

autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

source ~/.vim/plugin/cscope_maps.vim

autoclose html/xml tag autocmd BufNewFile,BufRead *.html,*.htm,*.xml inoremap </ </<c-x><c-o>
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
" 用退格键删除一个左括号时同时删除对应的右括号
inoremap <BS> <ESC>:call RemovePairs()<CR>a
function! RemoveNextDoubleChar(char)
  let l:line = getline(".")
  let l:next_char = l:line[col(".")] " 取得当前光标后一个字符

  if a:char == l:next_char
    execute "normal! l"
  else
    execute "normal! i" . a:char . ""
  end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
"set bg=dark
"set paste
"set nopaste
xnoremap p pgvy
au! BufRead,BufNewFile *.hta  setfiletype html
" let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" Mapping ESC in insert mode and command mode to double j
imap jj <C-[>
" cmap jj  <C-[]]
" This sets the minimum window height to 0, so you can stack many more files before things get crowded. Vim will only display the filename. 
set wmw=0
" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
" set nowrap                      " don't wrap lines

set wrap
set linebreak
set textwidth=0
set wrapmargin=0

set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=2                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
"set ignorecase                  " ignore case when searching
"set smartcase                   " ignore case if search pattern is all lowercase,
"    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
"    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set nolist                      " don't show invisible characters by default,
" but it is enabled for some file types (see later)
" set mouse=a                     " enable using the mouse if terminal emulator
"    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
"    with 1-letter words (looks stupid)

set nrformats=                  " make <C-a> and <C-x> play well with
"    zero-padded numbers (i.e. don't consider
"    them octal or hex)




" }}}
" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
"set foldmethod=manual " detect triple-{ style fold markers
"set foldmethod=syntax " detect triple-{ style fold markers
" set foldmethod=indent " detect triple-{ style fold markers
set syntax=c
set foldmethod=syntax

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

set foldlevelstart=99           " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" which commands trigger auto-unfold
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim'] 
" }}}
" Editor layout {{{
set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
"    if there is only one window
set cmdheight=1                 " use a status bar that is 2 rows high
" }}}
" Folding {{{
" }}}
" Edit the vimrc file
" Keep search matches in the middle of the window and pulse the line when moving
" to them.
" nnoremap n n:call PulseCursorLine()<cr>
" nnoremap N N:call PulseCursorLine()<cr>
" Pulse ------------------------------------------------------------------- {{{

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

" }}}
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" 获取当前路径，将$HOME转化为~
function! CurDir()
  let curdir = substitute(getcwd(), $HOME, "~", "g")
  return curdir
endfunction

" Set a nicer foldtext function
set foldtext=MyFoldText()
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

execute pathogen#infect()
" map <C-t> :tabedit 
:CommandT<CR>
" powerline{
"  set guifont=PowerlineSymbols\ for\ Powerline
"  set nocompatible
"  set t_Co=256
"  let g:Powerline_symbols = 'fancy'
"  }
" 设置tablist插件只显示当前编辑文件的tag内容，而非当前所有打开文件的tag内容
let Tlist_Show_One_File=1
"打开taglist窗口时，光标也进入到taglist窗口中
let Tlist_GainFocus_On_ToggleOpen = 1

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

:command -nargs=1 FF :vertical scscope find f <q-args>

" http://vim.wikia.com/wiki/Copy_filename_to_clipboard
" Convert slashes to backslashes for Windows.
" nnoremap fh <c-w>R
" nnoremap fl <c-w>r
" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on     " required!

function TrimEndLines()
  let save_cursor = getpos(".")
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction

au BufWritePre *.py call TrimEndLines()
au BufWritePre *.java call TrimEndLines()
au BufWritePre *.vimrc call TrimEndLines()
"To have a space (ASCII 32) considered as a valid character for a file name
":set isfname+=32
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
  set clipboard=unnamedplus
else
  set clipboard=unnamed 
endif
au FileType javascript call JavaScriptFold()
autocmd BufRead,BufNewFile *.txt setlocal spell

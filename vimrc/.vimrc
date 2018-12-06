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


autocmd BufEnter * call CHANGE_CURR_DIR()

autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

" 用退格键删除一个左括号时同时删除对应的右括号
inoremap <BS> <ESC>:call RemovePairs()<CR>a
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
set wmh=0
" Editing behaviour {{{
set showmode                    " always show what mode we're currently editing in
" set nowrap                      " don't wrap lines

set wrap
set linebreak
set textwidth=0
set wrapmargin=0

set tabstop=4                   " a tab is two spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
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
" autocmd BufWinEnter *.* silent loadview
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


" }}}
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

" Set a nicer foldtext function
set foldtext=MyFoldText()

execute pathogen#infect()
" map <C-t> :tabedit
" powerline{
"  set guifont=PowerlineSymbols\ for\ Powerline
"  set nocompatible
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

call pathogen#infect()
call pathogen#helptags()

syntax on

set nocompatible              " be iMproved

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype on
filetype plugin on
filetype plugin indent on

function AddToGit()
    let worktree = Find_in_parent(".git", Windowdir(), "/")
    exec "cd " . worktree
    let b:relativePath = substitute(expand('%:p'), worktree . '/', "", "g")
    exec 'silent !~/loadrc/gitrc/autoadd.sh ' . '"' .  b:relativePath . '"'
endfunction

function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', save_cursor)
endfunction

au BufWritePre *.py call TrimEndLines()
au BufWritePre *.sh call TrimEndLines()
au BufWritePre *.java call TrimEndLines()
au BufWritePre *.vimrc call TrimEndLines()
au BufWritePre *.* call AddToGit()
"to do: pymode_rope conflict with AddToGit(), it will cause vim hang.
let g:pymode_rope = 0
"To have a space (ASCII 32) considered as a valid character for a file name
":set isfname+=32
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
let g:phpfmt_autosave = 1
let g:phpfmt_standard = '$HOME/loadrc/vimrc/.vim/bundle/vim-phpfmt/ruleset.xml'

let g:ycm_autoclose_preview_window_after_completion = 1

if !has('nvim')
    set viminfo+=n~/.local/share/vim/viminfo
endif
set winwidth=999999
"
" configuration for cscope_dynamic
let cscopedb_auto_files=0

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" To have a space (ASCII 32) considered as a valid character for a file name
" set isfname+=32
au BufRead,BufNewFile *.vala,*.vapi,*.valadoc set filetype=vala

" configuration for vim-anyfold
filetype plugin indent on " required
syntax on                 " required

autocmd Filetype * AnyFoldActivate               " activate for all filetypes
" or
" autocmd Filetype <your-filetype> AnyFoldActivate " activate for a specific filetype

set foldlevel=0  " close all folds
" or
" set foldlevel=99 " Open all folds
let g:anyfold_fold_comments = 1 
let g:anyfold_identify_comments = 2
" configuration for vim-anyfold

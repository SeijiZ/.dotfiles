if !&compatible
    set nocompatible
endif

" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

" dein settings
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir)) 
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath

" read plugin
let s:toml_file = expand('$HOME/.dotfiles').'/dein.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:toml_file)
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" auto install if not 
if has('vim_starting') && dein#check_install()
    call dein#install()
endif


set number
set ruler
set noswapfile
set title
set hlsearch
set incsearch
set wildmenu 
set wildmode=list:full
set nobackup
set clipboard=unnamed
set hidden
set showmatch
"set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set list
set listchars=tab:>-,trail:-,nbsp:%,eol:$
set whichwrap=b,s,h,l,<,>,[,],~
set wrapscan
set ignorecase
set smartcase
set encoding=utf-8
set nowrap
set history=2000
set helplang=en
set cursorline
set scrolloff=5
set noswapfile
set nobackup
set viminfo=
set display=lastline
set foldmethod=marker
set autoread
set undodir=$HOME/.vim/undo
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => neovim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" check shell
if $SHELL =~ 'fish'
  set shell=bash
endif

let g:python3_host_prog = system('echo -n $(which python3)')

if !&compatible
  set nocompatible
endif

"reset augroup MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim basic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"highlight cursorline ohter than insert mode
autocmd WinEnter     * set cursorline
autocmd WinLeave     * set nocursorline
autocmd InsertEnter  * set nocursorline
autocmd InsertLeave  * set cursorline
highlight CursorLine term=reverse cterm=none ctermbg=235

"highlight cursorcolumn ohter than insert mode
autocmd WinEnter     * set cursorcolumn
autocmd WinLeave     * set nocursorcolumn
autocmd InsertEnter  * set nocursorcolumn
autocmd InsertLeave  * set cursorcolumn
highlight CursorColumn term=reverse cterm=none ctermbg=235

highlight VertSplit gui=none cterm=none ctermbg=none ctermfg=none

"quickfix
augroup quickfixConf
  autocmd!
  autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END


set showcmd
set number
set relativenumber
set ruler
set noswapfile
set nobackup
set title
set hlsearch
set incsearch
set wildmenu 
set wildmode=list:full
set wildignorecase
set hidden
"setting matching pair like <>,()
set showmatch
set matchtime=1
"set smarttab
set expandtab
set tabstop=2         " Number of spaces that a <Tab> in the file counts for
set shiftwidth=2      " Number of spaces to use for each step of (auto)indent.
set softtabstop=2     " Number of spaces that a <Tab> counts for while performing editing operations
" set autoindent
set smartindent
"display tab and eol
set list
"symbol of tab,trail,eol
set listchars=tab:>-,trail:-,nbsp:%,eol:$
set whichwrap=b,s,h,l,<,>,[,],~
set wrapscan
set ignorecase
set smartcase
set encoding=utf-8                  " buffer encoding
set fileencodings=utf-8,sjis,cp932  " read file with specified encoding
set fileencoding=utf-8              " write file with specified encoding
set nowrap
set history=2000
set helplang=en
set scrolloff=1000
set viminfo='300                   " expand oldfile to 200
if !has('nvim')
  set viminfo+=n$HOME/.local/share/viminfo
endif
set display=lastline
set foldmethod=marker
set autoread
set undofile
set undodir=$HOME/.local/share/nvim/undo
set backspace=indent,eol,start
" C-a and C-x motion ignore octal
set nrformats=
set timeout timeoutlen=1000 ttimeoutlen=75
"disable mouse
set mouse=
set splitright
set splitbelow
set noshowmode
set modifiable
set write
" set ambiwidth=double
set laststatus=2
"set completion's height
set pumheight=10
"set clipboard
if has('unnamedplus')
  set clipboard+=unnamedplus,unnamed
else
  set clipboard+=unnamed
endif

set infercase
"open buffer instead of open new
set switchbuf=useopen
"no flush and no beep
set visualbell t_vb=
"add < > pair
set matchpairs+=<:>
"make scroll faster and stable
set ttyfast
set lazyredraw
"error message
set shortmess=filnxtToOIA
" include '-' in keyword
" set iskeyword+=-,.
"message in English
language message C


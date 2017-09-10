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

" Unite vim settings-----------------------
nnoremap [unite] <Nop>
nmap  <Space> [unite]
" begin with insert mode
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>


au filetype unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au filetype unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" lightline vim settings ------------------

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ],['readonly', 'filepath', 'modified'] ]
            \ },
            \ 'component_function': {
            \ 'filepath': 'FilePath'
            \ },
            \ } 
if !has('gui_running')
    set t_Co=256
endif

function! FilePath()
    if winwidth(0) > 90
        return expand("%:p")
    else
       return expand("%:t")
    endif
endfunction

set noshowmode

" neocomplete.vim -------------------------
let g:neocomplete#enable_at_startup=1

" neosnippets.vim -------------------------
" Plugin key-mappings.
imap <C-k>    <Plug>(neosnippet_expand_or_jump)
smap <C-k>    <Plug>(neosnippet_expand_or_jump)
xmap <C-k>    <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippets#expandable_or_jumpable() ?
"            \"\<Plug>(neosnippet_expand_or_jump)" 
"            \: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippets#expandable_or_jumpable() ?
"            \"\<Plug>(neosnippet_expand_or_jump)" 
"            \: "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" syntastic -------------------------------
set statusline+=%#warningmsg#
set statusline+=%{syntasticstatuslineflag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-json - ------------------------------
let g:vim_json_syntax_conceal = 0

" vim settings ----------------------------
set laststatus=2
set showcmd
set number
set relativenumber
set ruler
set noswapfile
set title
set hlsearch
set incsearch
set wildmenu 
set wildmode=list:full
set nobackup
"set clipboard=unnamedplus
set hidden
set showmatch
"set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
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
set viminfo+=n$HOME/.cache/.viminfo
set display=lastline
set foldmethod=marker
set autoread
set undodir=$HOME/.cache//
set backspace=indent,eol,start
set nrformats=    " C-a and C-x motion ignore octal
set timeout timeoutlen=1000 ttimeoutlen=75
set mouse=

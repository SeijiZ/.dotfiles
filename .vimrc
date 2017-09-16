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
    call dein#add('Shougo/vimproc.vim',{'build' : 'make'})
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
" add bookmark current buffer
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
" open bookmark
nnoremap <silent> [unite]m :<C-u>Unite bookmark<CR>
" list most_recently_used file
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
" list most_recently_used directory
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep<CR>
" list buffer
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" list register
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
" list tab
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
" list open file directory
nnoremap <silent> [unite]l :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR> 
" search file recursive
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>


" split with C-s
au filetype unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('split')
au filetype unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('split')
" vsplit with C-v
au filetype unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au filetype unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" quit Unite with ESC*2
au filetype unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au filetype unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


" VimFiler settings -----------------------
nnoremap <silent> [unite]v :<C-u>VimFiler -simple -no-quit<CR>
nnoremap <silent> [unite]e :<C-u>VimFilerExplorer<CR>
call vimfiler#custom#profile('default', 'context', {
            \   'safe': 0,
            \   'explorer' : 1,
            \   'split' : 1,
            \   'direction' : 'topleft',
            \   'status' : 1
            \ })

let g:vimfiler_as_default_explorer = 1
au filetype VimFiler nnoremap <silent> <buffer> <expr> <C-k> vimfiler#do_action('split')
au filetype VimFiler nnoremap <silent> <buffer> <expr> <C-l> vimfiler#do_action('vsplit')
" lightline vim settings ------------------

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \ 'left': [ [ 'mode', 'paste' ],
            \           ['readonly', 'filename', 'modified'] ],
            \ 'right': [ ['lineinfo'],
            \            ['percent'],
            \            ['fileformat','fileencoding','filetype'] ]
            \ },
            \ 'component_function': {
            \ 'filepath': 'FilePath'
            \ },
            \ } 

let g:lightline.mode_map = {
            \ 'n' : 'Normal',
            \ 'i' : 'Insert',
            \ 'R' : 'Replace',
            \ 'v' : 'Visual',
            \ 'V' : 'V-Line',
            \ "\<C-v>": 'V-Block',
            \ 'c' : 'Command',
            \ 's' : 'Select',
            \ 'S' : 'S-Line',
            \ "\<C-s>": 'S-Block',
            \ 't': 'Terminal',
            \ }

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '>', 'right': '<' }
"if !has('gui_running')
"    set t_Co=256
"endif
"
"function! FilePath()
"    if winwidth(0) > 90
"        return expand("%:p")
"    else
"       return expand("%:t")
"    endif
"endfunction


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
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-json - ------------------------------
let g:vim_json_syntax_conceal = 0

" vim settings ----------------------------
set cursorline
highlight CursorLine term=reverse cterm=underline ctermfg=none ctermbg=none
"set cursorcolumn
set visualbell
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
"set clipboard=unnamed
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
set splitright
set splitbelow
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
nnoremap <silent> <C-n> :<C-u>bn<CR>
nnoremap <silent> <C-p> :<C-u>bp<CR>

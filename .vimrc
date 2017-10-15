if !&compatible
	set nocompatible
endif

"reset augroup
augroup MyAutoCmd
	autocmd!
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => dein.vim settings 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir)) 
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath

"read plugin
let s:toml_file = expand('$HOME/.dotfiles/vim/plugins/toml').'/dein.toml'
let s:toml_lazy_file = expand('$HOME/.dotfiles/vim/plugins/toml').'/dein_lazy.toml'
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
	call dein#load_toml(s:toml_file,      {'lazy':0})
	call dein#load_toml(s:toml_lazy_file, {'lazy':1})
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
colorscheme gotham
syntax enable

"auto install if not
if has('vim_starting') && dein#check_install()
    call dein#install()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
			\ 'colorscheme': 'gotham',
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim basic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"highlight cursorline ohter than insert mode
autocmd WinEnter     * set cursorline
autocmd WinLeave     * set nocursorline
autocmd InsertEnter  * set nocursorline
autocmd InsertLeave  * set cursorline
highlight CursorLine term=reverse cterm=none ctermbg=235

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
set hidden
"setting matching pair like <>,()
set showmatch
set matchtime=1
"set smarttab
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
"display tab and eol
set list
"symbol of tab,trail,eol
set listchars=tab:»-,trail:-,nbsp:%,eol:$
set whichwrap=b,s,h,l,<,>,[,],~
set wrapscan
set ignorecase
set smartcase
set encoding=utf-8
set nowrap
set history=2000
set helplang=en
set scrolloff=5
set viminfo+=n$HOME/.dotfiles/vim/tmp/.viminfo
set display=lastline
set foldmethod=marker
set autoread
set undodir=$HOME/.dotfiles/vim/tmp/
set undofile
set backspace=indent,eol,start
set nrformats=    " C-a and C-x motion ignore octal
set timeout timeoutlen=1000 ttimeoutlen=75
"disable mouse
set mouse=
set splitright
set splitbelow
set noshowmode
set modifiable
set write
set laststatus=2
"set completion's height
set pumheight=10
"visual to the end of the line
vnoremap v $h
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
set vb t_vb=
"add < > pair
set matchpairs+=<:>
"make scroll faster and stable
set ttyfast
set lazyredraw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prefix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap [Plug] <Nop>
nmap  <Space> [Plug]
xnoremap [Plug] <Nop>
xmap  <Space> [Plug]
nnoremap [Meta] <Nop>
nmap  , [Meta]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Normal mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Zoom/Restore window.
function! ZoomToggle() abort
	if exists('t:zoomed') && t:zoomed
		execute t:zoom_winrestcmd
		let t:zoomed = 0
	else
		let t:zoom_winrestcmd = winrestcmd()
		resize
		vertical resize
		let t:zoomed = 1
	endif
endfunction
nnoremap <silent> [Meta]z :<C-u>call ZoomToggle()<CR>
"source ~/.vimrc
nnoremap <silent> [Meta]v :<C-u>source ~/.vimrc<CR>
" toggle spell
nnoremap <silent> [Meta]s :<C-u>setl spell! spell?<CR>
" toggle list
nnoremap <silent> [Meta]l :<C-u>setl list! list?<CR>
nnoremap <silent> [Meta]t :<C-u>setl expandtab! expandtab?<CR>
nnoremap <silent> [Meta]w :<C-u>setl wrap! wrap?<CR>
nnoremap <silent> [Meta]p :<C-u>setl paste! paste?<CR>
nnoremap <silent> [Meta]b :<C-u>setl scrollbind! scrollbind?<CR>
function! s:toggle_syntax() abort
	if exists('g:syntax_on')
		syntax off
		redraw
		echo 'syntax off'
	else
		syntax on
		redraw
		echo 'syntax on'
	endif
endfunction
nnoremap <silent> [Meta]y :call <SID>toggle_syntax()<CR>

"move window
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
"move buffer
nnoremap <silent> <C-n> :<C-u>bn<CR>
nnoremap <silent> <C-p> :<C-u>bp<CR>
"move ^ and $
noremap <S-h> ^
noremap <S-l> $

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Insert mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"search inside selected range
vnoremap z/ <ESC>/\%
vnoremap z? <ESC>?\%V

"reselect after < or >
xnoremap < <gv
xnoremap > >gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save as sudo with w!!
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. install vim-plug
if has('nvim')
    let s:vim_plug_dir = '~/.local/share/nvim/site/autoload/'
else
    let s:vim_plug_dir = '~/.vim/autoload/'
endif

if empty(glob(s:vim_plug_dir . 'plug.vim'))
    echom system('echo "installing plug.vim"')
    echom system('curl -fLo ' . s:vim_plug_dir . 'plug.vim ' . '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
endif

" 2. install vim-plug
"
" download plugins with 'PlugInstall' command
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:vim_plug_home_dir = s:cache_home . '/plugged'

" read plugin settings
function! s:source_rc(name)
  let rc_file = expand('~/.dotfiles/vim/plugins/' . a:name)
  if filereadable(rc_file)
    execute 'source' rc_file
  endif
endfunction

function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction

" junegunn's plugins {{{
call plug#begin(s:vim_plug_home_dir)
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call s:source_rc('fzf.rc.vim')

Plug 'junegunn/vim-easy-align'
"Start interactive EasyAlign in visual mode (e.g. vipga)
vmap <Enter> <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" }}}

" Shougo's plugins {{{
Plug 'Shougo/unite.vim'
call s:source_rc('unite.rc.vim')

Plug 'Shougo/vimfiler.vim'
call s:source_rc('vimfiler.rc.vim')

Plug 'Shougo/junkfile.vim'
let g:junkfile#directory = $HOME . '/junk/'
nnoremap <silent> [Plug]j :<C-u>Unite junkfile/new junkfile<CR>

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do' : ':UpdateRemotePlugins'}
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  call s:source_rc('denite.rc.vim')
  Plug 'Shougo/defx.nvim', {'do' : ':UpdateRemotePlugins'}
  call s:source_rc('defx.rc.vim')
else
  Plug 'Shougo/deoplete.nvim', {'do' : 'make'}
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
" }}}

Plug 'simeji/winresizer'
nnoremap <silent> [Plug]w :WinResizerStartResize<CR> 

Plug 'emonkak/vim-accelerate'
if s:is_plugged('vim-accelerate')
  autocmd VimEnter * call accelerate#map('nv', '', 'j', 'gj')
  autocmd VimEnter * call accelerate#map('nv', '', 'k', 'gk')
  autocmd VimEnter * call accelerate#map('nv', '', 'l', 'l')
  autocmd VimEnter * call accelerate#map('nv', '', 'h', 'h')
endif

Plug 'thinca/vim-quickrun'
call s:source_rc('quickrun.rc.vim')

Plug 'thinca/vim-qfreplace'
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  cterm=none ctermbg=25
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven cterm=none ctermbg=6

Plug 'tyru/caw.vim'
nmap [Meta]/ <Plug>(caw:hatpos:toggle)
vmap [Meta]/ <Plug>(caw:hatpos:toggle)

Plug 'AndrewRadev/linediff.vim'

Plug 'w0rp/ale', {'branch' : 'v2.3.x'}
call s:source_rc('ale.rc.vim')

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'chase/vim-ansible-yaml'
let g:vim_markdown_new_list_item_indent = 2

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call s:source_rc('lsp.rc.vim')

Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/gtags.vim'

" colorscheme
Plug 'cocopon/iceberg.vim'
Plug 'gkeep/iceberg-dark'

Plug 'itchyny/lightline.vim'
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'icebergDark',
      \ 'component_function': {
      \   'filename': 'FilenameForLightline'
      \ }
      \ }
 
" Show full path of filename
function! FilenameForLightline()
    return expand('%')
  endfunction

call plug#end()

if s:is_plugged('iceberg.vim')
  set termguicolors
  colorscheme iceberg
endif


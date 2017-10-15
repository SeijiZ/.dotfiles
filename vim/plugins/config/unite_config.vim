""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"begin with insert mode
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_enable_auto_select = 0
"add bookmark current buffer
nnoremap <silent> [Plug]a :<C-u>UniteBookmarkAdd<CR>
"open bookmark
nnoremap <silent> [Plug]m :<C-u>Unite bookmark<CR>
"list most_recently_used file
nnoremap <silent> [Plug]f :<C-u>Unite<Space>buffer file_mru<CR>
"list most_recently_used directory
nnoremap <silent> [Plug]d :<C-u>Unite<Space>directory_mru<CR>
"list buffer
nnoremap <silent> [Plug]b :<C-u>Unite<Space>buffer<CR>
"list register
nnoremap <silent> [Plug]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [Plug]y :<C-u>Unite<Space>history/yank<CR>
"list tab
nnoremap <silent> [Plug]t :<C-u>Unite<Space>tab<CR>
"list open file directory
nnoremap <silent> [Plug]l :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Plug]h :<C-u>Unite<Space>history/unite<CR>
"search file recursive
nnoremap <silent> [Plug]<CR> :<C-u>UniteWithBufferDir<Space>file_rec/async<CR>
"search current directory
nnoremap <silent> [Plug]c :<C-u>Unite<Space>file/async<CR>

call unite#custom#profile('default', 'context', {
		\   'start_insert': 1,
		\   'winheight': 12
		\ })

"split with C-s
"au filetype unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('split')
"au filetype unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('split')
"" vsplit with C-v
"au filetype unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
"au filetype unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
"quit Unite with ESC*2
autocmd MyAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() abort
" Directory partial match
call unite#custom#default_action('directory','narrow')

"overwrite settings
imap <buffer>  jj         <Plug>(unite_insert_leave)
nnoremap <silent><buffer> <Tab>     <C-w>w
nmap <buffer> x           <Plug>(unite_quick_match_jump)
nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
inoremap <silent> <buffer> <C-k> <C-o>D
endfunction

"******************** enable ag instead of grep ********************
nnoremap <silent> [Plug]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
if executable('ag')
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
let g:unite_source_grep_recursive_opt = ''
endif

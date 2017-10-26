""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd VimEnter * call unite#custom#profile('default', 'context', {
			\   'start_insert': 1,
			\   'winheight': 12,
			\   'direction': 'botright',
			\ })

let g:unite_enable_auto_select = 0
let g:unite_restore_alternate_file = 1
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_enable_auto_select = 0
"list most_recently_used file
nnoremap <silent> [Plug]uf :<C-u>Unite buffer file_mru<CR>
"list buffer
nnoremap <silent> [Plug]ub :<C-u>Unite buffer<CR>
"list most_recently_used directory
nnoremap <silent> [Plug]ud :<C-u>Unite directory_mru<CR>
"history
nnoremap <silent> [Plug]uy :<C-u>Unite register history/yank<CR>
"list tab
nnoremap <silent> [Plug]ut :<C-u>Unite tab<CR>
"list open file directory
"search current directory
nnoremap <silent> [Plug]us :<C-u>Unite file_rec/async<CR>
nnoremap <silent> [Plug]ul :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Plug]uh :<C-u>Unite history/unite<CR>
" enable ag instead of grep
nnoremap <silent> [Plug]ug :<C-u>Unite grep:. -buffer-name=search<CR>
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif


autocmd MyAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() abort
	" Directory partial match
	call unite#custom#default_action('directory','narrow')

	"overwrite settings
	imap <buffer>  jj         <Plug>(unite_insert_leave)
	imap <buffer>  kk         <Plug>(unite_insert_leave)
	nmap <buffer> x           <Plug>(unite_quick_match_jump)
	"quit Unite with ESC*2
	nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
	inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
	inoremap <silent> <buffer> <C-k> <C-o>D
endfunction

" unite menu
let g:unite_source_menu_menus = get(g:,'unite_source_menu_menus',{})
let g:unite_source_menu_menus.git = {
			\ 'description' : 'git commands list'
			\}
let g:unite_source_menu_menus.git.command_candidates = [
			\['tig                                                        ',
			\'normal ,gt'],
			\['git status       (Fugitive:Gstatus)                        ',
			\'Gstatus'],
			\['git diff         (Fugitive:Gdiff)                          ',
			\'Gdiff'],
			\['git commit       (Fugitive:Gcommit)                        ',
			\'Gcommit'],
			\['git log          (Fugitive:Glog)                           ',
			\'exe "silent Glog | Unite quickfix"'],
			\['git blame        (Fugitive:Gblame)                         ',
			\'Gblame'],
			\['git stage        (Fugitive:Gwrite)                         ',
			\'Gwrite'],
			\['git checkout     (Fugitive:Gread)                          ',
			\'Gread'],
			\['git rm           (Fugitive:Gremove)                        ',
			\'Gremove'],
			\['git mv           (Fugitive:Gmove)                          ',
			\'exe "Gmove " input("destino: ")'],
			\['git push         (Fugitive, salida por buffer)             ',
			\'Git! push'],
			\['git pull         (Fugitive, salida por buffer)             ',
			\'Git! pull'],
			\['git prompt       (Fugitive, salida por buffer)             ',
			\'exe "Git! " input("comando git: ")'],
			\['git cd           (Fugitive)',
			\'Gcd'],
			\]
nnoremap <silent> [Plug]um :<C-u>Unite menu<CR>

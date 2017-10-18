""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"begin with insert mode
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_enable_auto_select = 0
"open bookmark
"list most_recently_used file
nnoremap <silent> [Plug]f :<C-u>Unite<Space>buffer file_mru<CR>
"list most_recently_used directory
nnoremap <silent> [Plug]d :<C-u>Unite<Space>directory_mru<CR>
"list buffer
nnoremap <silent> [Plug]b :<C-u>Unite<Space>buffer<CR>
"history
nnoremap <silent> [Plug]y :<C-u>Unite<Space>history/yank<CR>
"list tab
nnoremap <silent> [Plug]t :<C-u>Unite<Space>tab<CR>
"list open file directory
nnoremap <silent> [Plug]l :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Plug]h :<C-u>Unite<Space>history/unite<CR>
"search file recursive and if inside git work tree, exec file_rec/git
function! IsInsideWorkTree()
	cd %:p:h
	let l:is_inside = system('git rev-parse --is-inside-work-tree')
	return l:is_inside == "true\n" ? 1 : 0
endfunction

function! UniteFileRecSource()
	if IsInsideWorkTree()
		let dir = unite#util#path2project_directory(expand('%'))
		execute 'Unite file_rec/git:' .dir
	else
		execute 'UniteWithBufferDir file_rec/async'
	endif
endfunction
nnoremap <silent> [Plug]<CR> :<C-u>call UniteFileRecSource()<CR>
"search current directory
nnoremap <silent> [Plug]c :<C-u>Unite<Space>file/async<CR>

call unite#custom#profile('default', 'context', {
			\   'start_insert': 1,
			\   'winheight': 12
			\ })

autocmd MyAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() abort
	" Directory partial match
	call unite#custom#default_action('directory','narrow')

	"overwrite settings
	imap <buffer>  jj         <Plug>(unite_insert_leave)
	nnoremap <silent><buffer> <Tab>     <C-w>w
	nmap <buffer> x           <Plug>(unite_quick_match_jump)
"quit Unite with ESC*2
	nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
	inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
	inoremap <silent> <buffer> <C-k> <C-o>D
endfunction

" enable ag instead of grep
nnoremap <silent> [Plug]ag :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif

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
nnoremap <silent> [Plug]m :<C-u>Unite menu<CR>

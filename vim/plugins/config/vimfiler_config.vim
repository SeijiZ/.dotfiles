""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimfiler.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimfiler_as_default_explorer = 1

autocmd VimEnter *  call vimfiler#custom#profile('default', 'context', {
			\   'safe': 0,
			\   'explorer' : 1,
			\   'winwidth' : 30,
			\   'split' : 1,
			\   'direction' : 'topleft',
			\   'auto_expand': 1,
			\   'no-quit': 1,
			\   'force_hide': 0,
			\   'parent': 0,
			\   'toggle': 1,
			\ })

nnoremap <silent> [Plug]e :<C-u>VimFilerBufferDir -no-quit<CR>

function! s:set_vimfiler()
	augroup my-filetype-vimfiler
		autocmd! * <buffer>
		autocmd CursorMoved <buffer> execute "normal \<Plug>(vimfiler_print_filename)"
	augroup END
endfunction

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() abort
	call s:set_vimfiler()
	nmap <buffer> <C-j> <C-w>j
	nmap <buffer> <C-k> <C-w>k
	nmap <buffer> <C-h> <C-w>h
	nmap <buffer> <C-l> <C-w>l
endfunction

			" \   'explorer_columns': 'type',
			" \   'columns': 'type',
			" \   'hidden' : 1,
			" \   'status' : 1,
			" \   'auto-cd' : 1

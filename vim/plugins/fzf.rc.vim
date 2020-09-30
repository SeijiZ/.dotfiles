" input() wrapper function that enable cancel with type <ESC>
function! s:input(...) abort
  new
  cnoremap <buffer> <Esc> __CANCELED__<CR>
  let ret = call('input', a:000)
  bwipeout!
  redraw
  if ret =~# '__CANCELED__$'
    throw 'Canceled'
  endif
  return ret
endfunction

function! s:fzf_entry_point_files(lines)
    call fzf#vim#files(a:lines[0], fzf#vim#with_preview())
endfunction

function! s:fzf_entry_point_ag(lines)
    let word = s:input('Search Word > ')
    call fzf#vim#ag(word, extend(fzf#vim#with_preview(),{'dir': a:lines[0]}))
endfunction

let g:fzf_action = {
  \ 'ctrl-t': 'tabedit',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-f': function('s:fzf_entry_point_files'),
  \ 'ctrl-g': function('s:fzf_entry_point_ag')
  \}
let g:fzf_layout = { 'down': '~40%' }

" override History
command! -bang -nargs=? -complete=dir History
  \ call fzf#vim#history(fzf#vim#with_preview())

" override Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" override Buffers
" command! -bang -nargs=? -complete=dir Buffers
"  \ call fzf#vim#buffers(fzf#vim#with_preview())

" list directory
command! -bang -nargs=? -complete=dir Directories
  \ call fzf#run(fzf#wrap({
  \ 'down': '40%',
  \ 'source': 'find ~ -maxdepth 2 -type d',
  \ 'options': '--multi --prompt "Spotlight> "'
  \ }))

nnoremap <silent> [Plug]f :Files<CR>
nnoremap <silent> [Plug]b :Buffers<CR>
nnoremap <silent> [Plug]h :History<CR>
nnoremap <silent> [Plug]l :Lines<CR>
nnoremap <silent> [Plug]d :Directories<CR>


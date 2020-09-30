""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-quickrun 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:quickrun_config = {
      \   "_" : {
      \       "hook/close_unite_quickfix/enable_hook_loaded" : 1,
      \       "hook/unite_quickfix/enable_failure" : 1,
      \       "hook/close_quickfix/enable_exit" : 1,
      \       "hook/close_buffer/enable_failure" : 1,
      \       "hook/close_buffer/enable_empty_data" : 1,
      \       "hook/time/enable" : 1,
      \       "runner" : "vimproc",
      \       "runner/vimproc/updatetime" : 60,
      \       "outputter/buffer/split" : ":botright 8sp",
      \   },
      \   "python" : {
      \       "command" : "python3",
      \   },
      \   'sql': {
      \       'exec': "%c execsql -dsn %a -statementdelimiter \\@ -inputsql %s",
      \       'command': 'db2cli',
      \       'args': '%{input("Enter database name > ")}'
      \   },
      \   'jcl': {
      \       'exec': '%c %s | ssh %a "submit"',
      \       'command': 'cat',
      \       'args': '%{input("Enter ssh hostname > ")}'
      \   },
      \}
nnoremap <silent> [Plug]r :QuickRun<CR>
" execute seleted range
vnoremap <silent> [Plug]r :QuickRun -mode v<CR>

" quit
nnoremap <expr><silent> [Plug]q quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


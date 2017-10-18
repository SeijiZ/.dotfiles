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
			\}
nnoremap <silent> [Plug]q :QuickRun<CR>
" execute seleted range
vnoremap <silent> [Plug]q :QuickRun -mode v<CR>

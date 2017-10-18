""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"git status
nnoremap <silent> [Plug]gs :Gstatus<CR>
"git add
nnoremap <silent> [Plug]ga :Gwrite<CR>
"git commit
nnoremap <silent> [Plug]gc :Gcommit-v<CR>
"git blame
nnoremap <silent> [Plug]gb :Gblame<CR>
"git diff
nnoremap <silent> [Plug]gd :Gdiff<CR>
"git merge
nnoremap <silent> [Plug]gm :Gmerge<CR>

autocmd QuickFixCmdPost *grep* cwindow

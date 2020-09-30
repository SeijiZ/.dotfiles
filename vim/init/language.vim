""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => language environment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set filetype
augroup set_filetype
    autocmd!
    autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd BufNewFile,BufRead *.md set filetype=markdown
    autocmd BufNewFile,BufRead *.jcl set filetype=jcl
augroup END

augroup python_env
    autocmd!
    autocmd Filetype python setlocal softtabstop=4 shiftwidth=4 tabstop=4 expandtab
    autocmd FileType python setlocal keywordprg=pydoc
augroup END

augroup vim_env
    autocmd!
    autocmd FileType vim setlocal keywordprg=:help
augroup END


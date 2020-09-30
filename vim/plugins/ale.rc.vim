" when to kick ALELint
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_virtualtext_cursor = 1
let g:ale_fix_on_save = 1

let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
nmap <silent> [Plug]<C-n> <Plug>(ale_next)
nmap <silent> [Plug]<C-p> <Plug>(ale_previous)
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '=='

let g:ale_linters = {
      \'cpp': ['clang'],
      \'javascript': ['eslint','flow'],
      \'typescript': ['tslint', 'tsserver', 'typecheck'],
      \'python': ['flake8'],
      \'zsh': ['shell']
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => javascript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_javascript_eslint_use_global = 1
let g:ale_typescript_tslint_use_global = 1
let g:ale_javascript_flow_use_global = 1


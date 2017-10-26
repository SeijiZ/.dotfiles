""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => deoplete.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1

call deoplete#custom#source('_','converters',[
			\'converter_remove_paren',
			\'converter_remove_overlap',
			\'converter_truncate_abbr',
			\'converter_truncate_menu',
			\'converter_auto_delimiter',
			\])

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
let g:deoplete#keyword_patterns.tex = '[^\w|\s][a-zA-Z_]\w*'

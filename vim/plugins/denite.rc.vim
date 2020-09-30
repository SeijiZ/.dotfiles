""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => denite.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
if executable('ag')
  call denite#custom#var('file_rec', 'command',
        \ ['ag', '-U','--hidden', '--follow', '--nocolor', '--nogroup', '-g',''])
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
  call denite#custom#var('grep', 'default_opts',
        \ [ '--vimgrep', '--smart-case', '--hidden' ])
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<C-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ 'jj',
      \ '<denite:enter_mode:normal>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ 'kk',
      \ '<denite:enter_mode:normal>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<ESC>',
      \ '<denite:enter_mode:normal>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-r>',
      \ '<denite:toggle_matchers:matcher_substring>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-s>',
      \ '<denite:toggle_sorters:sorter_reverse>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'normal',
      \ 'sp',
      \ '<denite:do_action:split>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'normal',
      \ 'vs',
      \ '<denite:do_action:vsplit>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'normal',
      \ 'r',
      \ '<denite:redraw>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'normal',
      \ '<ESC>',
      \ '<denite:quit>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'normal',
      \ '<C-s>',
      \ '<denite:toggle_sorters:sorter_reverse>',
      \ 'noremap'
      \)


"list buffer and most_recently_used files
nnoremap <silent> [Plug]f :<C-u>Denite buffer file_old -highlight-mode-insert=Search<CR>
"list buffer
nnoremap <silent> [Plug]b :<C-u>Denite buffer -highlight-mode-insert=Search<CR>
"list buffer and most_recently_used files
nnoremap <silent> [Plug]d :<C-u>Denite directory_mru<CR>
"register and yank history
nnoremap <silent> [Plug]y :<C-u>Denite -buffer-name=register register neoyank<CR>
xnoremap <silent> [Plug]y :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>
"recursive grep from active buffer directory
nnoremap <silent> [Plug]g :<C-u>Denite -buffer-name=search -no-empty -mode=normal grep<CR>
"exec file_rec and if in the git managed directory, exec file_rec/git
nnoremap <silent> [Plug]s :<C-u>Denite file_point
      \ -sorters=sorter_rank
      \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
"active buffer search
nnoremap <silent> [Plug]/ :<C-u>Denite -buffer-name=search -auto-highlight line<CR>
nnoremap <silent> [Plug]* :<C-u>DeniteCursorWord -buffer-name=search -auto-highlight -mode=normal line<CR>
"resume search buffer
nnoremap <silent> [Plug]n :<C-u>Denite -buffer-name=search
      \ -resume -mode=normal -refresh<CR>
"tagjump and return
nnoremap <silent><expr> [Plug]t  &filetype == 'help' ?  "g\<C-]>" :
      \ ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately
      \  tag:include\<CR>"
nnoremap <silent><expr> [Plug]p  &filetype == 'help' ?
      \ ":\<C-u>pop\<CR>" : ":\<C-u>Denite -mode=normal jump\<CR>"
"command_history and command
nnoremap <silent> [Plug]: :<C-u>Denite command_history command<CR>
"denite git

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change prompt
call denite#custom#option('default',{
      \'prompt': '>',
      \'winheight': '10',
      \'auto_accel': 'true',
      \'highlight-mode-insert': 'Search',
      \})
call denite#custom#option('search',{
      \'prompt': '>',
      \'winheight': '10',
      \'auto_accel': 'true',
      \'highlight-mode-insert': 'Search',
      \})
call denite#custom#option('register',{
      \'prompt': '>',
      \'winheight': '10',
      \'auto_accel': 'true',
      \'highlight-mode-insert': 'Search',
      \})
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#action('directory','file_rec','FileRecDirectory')
function! FileRecDirectory(context) 
  echomsg context
endfunction


let s:menus = {}
let s:menus.vim = {
      \ 'description': 'Vim',
      \ }
let s:menus.vim.file_candidates = [
      \ ['    > Edit configuation file (init.vim)', '~/.config/nvim/init.vim']
      \ ]
call denite#custom#var('menu', 'menus', s:menus)

let s:menus.git = {
      \ 'description' : 'git commands list'
      \}
let s:menus.git.command_candidates = [
      \['git status       (Fugitive:Gstatus)                        ',
      \'Gstatus'],
      \['git diff         (Fugitive:Gdiff)                          ',
      \'Gdiff'],
      \['git commit       (Fugitive:Gcommit)                        ',
      \'Gcommit'],
      \['git log          (Fugitive:Glog)                           ',
      \'exe "silent Glog" | copen'],
      \['git blame        (Fugitive:Gblame)                         ',
      \'Gblame'],
      \['git stage        (Fugitive:Gwrite)                         ',
      \'Gwrite'],
      \['git checkout     (Fugitive:Gread)                          ',
      \'Gread'],
      \['git rm           (Fugitive:Gremove)                        ',
      \'Gremove'],
      \['git mv           (Fugitive:Gmove)                          ',
      \'exe "Gmove " input("destination: ")'],
      \['git push         (Fugitive, output buffer)                 ',
      \'Git! push'],
      \['git pull         (Fugitive, output buffer)                 ',
      \'Git! pull'],
      \['git prompt       (Fugitive, output buffer)                 ',
      \'exe "Git! " input("command git: ")'],
      \['git cd           (Fugitive)',
      \'Gcd'],
      \['test cd           (Fugitive)',
      \'echo "hello"'],
      \]

let s:menus.remote = {
      \ 'description': 'remote access',
      \ }

let s:menus.remote.command_candidates = [
      \['ssh ubuntu@192.168.33.10', 'Denite remote_access:"ssh ubuntu@192.168.33.10"'],
      \]


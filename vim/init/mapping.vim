""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prefix
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap [Plug] <Nop>
nmap  <Space> [Plug]
xnoremap [Plug] <Nop>
xmap  <Space> [Plug]
nnoremap [Meta] <Nop>
nmap  , [Meta]
xnoremap [Meta] <Nop>
xmap  , [Meta]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Normal mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Zoom/Restore window.
function! ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
function! TabToggle() abort
    if &expandtab
        setl noexpandtab
        :%retab!
    else
        setl expandtab
        :%retab!
    endif
endfunction
nnoremap <silent> [Meta]z :<C-u>call ZoomToggle()<CR>
"source ~/.vimrc
nnoremap <silent> [Meta]v :<C-u>source ~/.vimrc<CR>
" toggle spell
nnoremap <silent> [Meta]s :<C-u>setl spell! spell?<CR>
" toggle list
nnoremap <silent> [Meta]a :<C-u>setl smartindent! smartindent?<CR>
nnoremap <silent> [Meta]l :<C-u>setl list! list?<CR>
nnoremap <silent> [Meta]t :<C-u>call TabToggle()<CR>
nnoremap <silent> [Meta]w :<C-u>setl wrap! wrap?<CR>
nnoremap <silent> [Meta]p :<C-u>setl paste! paste?<CR>
nnoremap <silent> [Meta]b :<C-u>setl scrollbind! scrollbind?<CR>
nnoremap <silent> [Meta]m :<C-u>Man 
nnoremap <silent> [Meta]i :<C-u>IndentGuidesToggle<CR>
function! s:toggle_syntax() abort
    if exists('g:syntax_on')
        syntax off
        redraw
        echo 'syntax off'
    else
        syntax on
        redraw
        echo 'syntax on'
    endif
endfunction
nnoremap <silent> [Meta]y :call <SID>toggle_syntax()<CR>

"move buffer
nnoremap <silent> <C-n> :<C-u>tabn<CR>
nnoremap <silent> <C-p> :<C-u>tabp<CR>
"move ^ and $
noremap <S-h> ^
noremap <S-l> $
"move window
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
"search as very magic
nnoremap / /\v
nnoremap * *N
"%!xxd
nnoremap <silent> [Meta]x :%!xxd 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Insert mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"search inside selected range
vnoremap z/ <ESC>/\%V
vnoremap z? <ESC>?\%V

"reselect after < or >
xnoremap < <gv
xnoremap > >gv

"visual to the end of the line
vnoremap v $h


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" save as sudo with w!!
cnoremap w!! w !sudo tee % > /dev/null %<CR> :e!<CR>

function! s:search(pat)
    let g:search_yank_cache = []
    execute '%s/' . a:pat . '/\=add(g:cache, submatch(0))/n'
    call setreg(v:register,join(g:search_yank_cache, "\n"))
endfunction
command! -nargs=* SearchYank call s:search(<q-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Terminal mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    " set terminal color
    let g:terminal_color_0  = "#2E3436"
    let g:terminal_color_1  = "#CC0000"
    let g:terminal_color_2  = "#4E9A06"
    let g:terminal_color_3  = "#C4A000"
    let g:terminal_color_4  = "#3465A4"
    let g:terminal_color_5  = "#75507B"
    let g:terminal_color_6  = "#93A1A1"
    let g:terminal_color_7  = "#D3D7CF"
    let g:terminal_color_8  = "#555753"
    let g:terminal_color_9  = "#EF2929"
    let g:terminal_color_10 = "#8AE234"
    let g:terminal_color_11 = "#FCE94F"
    let g:terminal_color_12 = "#729FCF"
    let g:terminal_color_13 = "#AD7FA8"
    let g:terminal_color_14 = "#34E2E2"
    let g:terminal_color_15 = "#EEEEEC"
    tnoremap <silent> <C-Space> <C-\><C-n>
    " function! EscToggle() abort
    "     if exists('t:vim_in_terminal') && t:vim_in_terminal
    "         tnoremap <silent> <ESC> <C-\><C-n>
    "         let t:vim_in_terminal = 0
    "     else
    "         tunmap <ESC>
    "         let t:vim_in_terminal = 1
    "     endif
    " endfunction
    " tnoremap <silent> <C-\><C-z> :<C-u>call EscToggle()<CR>
else
    tnoremap <silent> <Nul> <C-\><C-n>
endif


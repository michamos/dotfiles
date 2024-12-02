require('config.lazy')
vim.cmd [[

" Mappings {{{1
" =============

" other convenient mappings {{{2
" ------------------------------

" 'Y' is consistent with other mappings, copies to end of line
noremap Y y$

" move by displayed line
nnoremap t gj
nnoremap s gk
xnoremap t gj
xnoremap s gk

" write the buffer more easily
noremap <Leader><Leader> :w<CR>

" show some useful lists
noremap <Leader>b :ls<CR>:b<space>
noremap <Leader>' :marks<CR>
noremap <Leader>" :registers<CR>

" toggle the display of hidden characters (in 'listchars')
noremap <silent> <Leader>cl :set list!<CR>

" cd to the directory of the current file
noremap <silent> <Leader>cd :cd %:p:h<CR>

" '<Esc>' is far away, use '<C-Space>' instead
noremap <C-Space> <Esc>
inoremap <C-Space> <Esc>
cnoremap <C-Space> <C-C>
snoremap <C-Space> <C-C>
map <Nul> <C-Space>
imap <Nul> <C-Space>
cmap <Nul> <C-Space>
smap <Nul> <C-Space>

" Use ' to go to the exact mark, since it is more accessible
noremap ' `
noremap ` '

" Use 'C'/'R' to operate on the current line rather than the screen
" we want 'C' to alternate between first non-blank character and start of line
function! Caret(mode)
  if(a:mode=='x')
    normal! gv
  endif
  let pos = col('.')
  normal! ^
  if pos == col('.')
    normal! 0
  endif
endfunction
nnoremap <silent> C :call Caret('n')<CR>
onoremap <silent> C :call Caret('o')<CR>
xnoremap <silent> C :<c-u>call Caret('x')<CR>
noremap R $

" Use 'U' for redo, basic 'U' is useless
noremap U <C-r>

" '*' is far away, we use 'M' to put the word under the cursor in the search
" register, then we can move with 'n'/'N'
noremap <silent> M :silent! execute "normal! *\<C-o>"<CR>

" Directional arrows operate on windows
noremap <left> <C-w>h
noremap <down> <C-w>j
noremap <up> <C-w>k
noremap <right> <C-w>l
noremap <S-left> <C-w>H
noremap <S-down> <C-w>J
noremap <S-up> <C-w>K
noremap <S-right> <C-w>L

" Jump open fold when jumping with '[count]G'
nnoremap <expr> G (v:count ? 'Gzv' : 'G')

"Convenient to move to end of next fold and open it
noremap <Leader>z zjzxzjk

"Yank all buffer to system clipboard as HTML using pandoc
noremap <silent> <Leader>y :<C-u>silent! w ! pandoc -t html \| wl-copy -t text/html<CR>

" Plug-ins configuration {{{1
" ===========================

" gundo {{{2
" ----------
if has('python3')
    let g:gundo_prefer_python3 = 1          " anything else breaks on Ubuntu 16.04+
endif
nnoremap <silent> <Leader>u :GundoToggle<CR>
let g:gundo_map_move_older="t"
let g:gundo_map_move_newer="s"

" tagbar {{{2
" -----------
nnoremap <silent> <Leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_autoclose = 1
let g:tagbar_map_togglesort="k"
" not needed if using ctags > 5.8
" let g:tagbar_type_tex = {
" 			\ 'ctagstype' : 'latex',
" 			\ 'kinds'     : [
" 			\ 's:sections',
" 			\ 'g:graphics:0:0',
" 			\ 'l:labels',
" 			\ 'r:refs:1:0',
" 			\ 'p:pagerefs:1:0'
" 			\ ],
" 			\ 'sort'    : 0
" 			\ }
let g:tagbar_type_bib = {
      \ 'ctagstype' : 'bibtex',
      \ 'kinds'     : [
      \ 'b:bibitems'
      \ ]
      \ }

" vim-airline {{{2
" ----------------
let g:airline_powerline_fonts=1

" fugitive {{{2
" -------------
let g:fugitive_git_executable = 'LANG=en git' "fugitive is not so good with translations
noremap <Leader>g :Gstatus<CR>

" latex {{{2
" ----------
let g:tex_flavor='latex'
" remove sub/superscripts replacement with conceal
let g:tex_conceal='abdgm'
let g:vimtex_compiler_method='latexrun'
" let g:vimtex_latexmk_continuous=0
" let g:vimtex_latexmk_background=1
" let g:vimtex_latexmk_options="-pdflatex='pdflatex -synctex=1 \\%O \\%S'"
let g:vimtex_view_method = 'zathura'
let g:vimtex_imaps_leader='’'

" ultisnips {{{2
" --------------
let g:UltiSnipsEditSplit="horizontal"
" use <C-{t,s}> to jump between snippet insertions
let g:UltiSnipsJumpForwardTrigger="<C-t>"
let g:UltiSnipsJumpBackwardTrigger="<C-s>"
let g:UltiSnipsDontReverseSearchPath="1" "necessary to make overrides work correctly, with vundle rtp

" vim-exchange {{{2
" -----------------
nmap lx <Plug>(Exchange)
xmap X <Plug>(Exchange)
nmap lxc <Plug>(ExchangeClear)
nmap lxx <Plug>(ExchangeLine)

" vim-commentary {{{2
" -------------------
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>Commentary_
nmap gcu <Plug>Commentary<Plug>Commentary

" vim-braceless {{{2
" ------------------

augroup vimrc_braceless
  autocmd!
  autocmd FileType python,yaml BracelessEnable +highlight
augroup END
highlight! link BracelessIndent ColorColumn

" vim-grepper {{{2
" ----------------
let g:grepper= { 'tools': ['rg', 'ag', 'git', 'grep'] }

" vim-arxivist {{{2
" -----------------
let g:arxivist_dir="~/Dropbox/notes/"
let g:arxivist_archive="hep-th"

" vim-pandoc {{{2
" ---------------
let g:pandoc#folding#fdc=0
let g:pandoc#keyboard#display_motions=0

" vim-easy-align {{{2
" -------------------
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader><Enter> <Plug>(EasyAlign)

" ale {{2
" -------
" Quickly jump to previous/next linter warning
nmap [l <Plug>(ale_previous_wrap)
nmap ]l <Plug>(ale_next_wrap)

" fzf {{{2
" --------
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Hide terminal status bar
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

map <silent> <leader>f :FZF<CR>

" vim-rest-console {{{2
" ---------------------
let g:vrc_set_default_mapping = 0
let g:vrc_curl_opts = {
  \ '-sSi': '',
  \}
command! HTTPRequest :call VrcQuery()
" Style {{{1
" ----------
set title
if has("termguicolors")
  set termguicolors
endif
if has("gui_running") || has("termguicolors")
  autocmd! VimEnter * colorscheme solarized8 | AirlineTheme solarized
endif
if has("gui_running")
  set guioptions-=T " no buttons nor menus
  set guioptions-=m
  set guioptions^=c " no gui dialog boxes
  if has("gui_gtk2") || has("gui_gtk3")
    if hostname() == 'shiva'
      let s:fontsize = 14
      set linespace=2 "workaround for disappearing underscores
      set guioptions-=L "workaround for cursor disappearing bug
    else
      let s:fontsize = 10
    endif
    execute 'set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ ' . s:fontsize
  elseif has("gui_macvim")
    set guifont=Menlo\ for\ Powerline:h12
  endif
endif

" toggle between light and dark colors easily {{{2
function! ToggleBG()
  if &background=='light'
    set background=dark
  else
    set background=light
  endif
endfunction
noremap <silent> <Leader>s :call ToggleBG()<CR>

" Various settings {{{1
" =====================

" open the current buffer with the default program {{{2
" -----------------------------------------------------
function! SysOpen()
  if has("macunix")
    let s:opencmd="open"
  elseif has("unix") "assuming linux if not OSX
    let s:opencmd="xdg-open"
  endif
  call system(s:opencmd ." ". expand("%"))
endfunction
noremap <silent> <Leader>o :call SysOpen()<CR>

" search {{{2
" -----------
set hlsearch
set ignorecase
set smartcase
set incsearch
" Use <C-L> instead from sensible.vim
" noremap <silent> <Leader>n :nohlsearch<CR>

" error displayed visually {{{2
" -----------------------------
set visualbell

" disable mouse in insert mode {{{2
" ---------------------------------
"  the standard setting is responsible for mistakes when inadvertently
"  touching the touchpad
set mouse=nvc

" status {{{2
" -----------
"set relativenumber
set ruler
set showcmd "show incomplete commands

" conceal characters, especially nice for TeX {{{2
" ------------------------------------------------
set conceallevel=2

" use unicode characters for listchars, stolen from previous version of
" sensible
" ---------------------------------------------------------------------
if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
endif

" command-line completion {{{2
" ----------------------------
set wildmenu
set wildmode=longest:full,full

" persistent undo {{{2
" --------------------
set undofile
set undodir=$HOME/.vim/undodir
if ! isdirectory(&undodir)
  call mkdir(&undodir)
endif

" changing buffers {{{2
" ---------------------
set autoread
set confirm

" generate ctags on each write {{{2
" ---------------------------------
augroup vimrc_auto_ctags
  autocmd!
  autocmd BufWritePost *
        \ if exists('b:git_dir') && executable(b:git_dir.'/hooks/ctags') |
        \   call system('"'.b:git_dir.'/hooks/ctags" &') |
        \ endif
augroup END

" spelling {{{2
" -------------
set spellfile=~/.vim/spell/myspell.utf-8.add
set spell
if empty(glob(&spellfile))
  silent execute "mkspell!"  &spellfile
endif

" source the .vimrc file on save to apply all changes immediately {{{2
" --------------------------------------------------------------------
autocmd! BufWritePost init.lua source ~/.config/nvim/init.lua | AirlineRefresh

" edit nvim config easily {{{2
" -------------------------
noremap <Leader>ed :split ~/.homesick/repos/dotfiles/home/<CR>
noremap <Leader>ev :split ~/.homesick/repos/dotfiles/home/.config/nvim/init.lua<CR>
command! -bang -nargs=? Ftedit execute "edit ~/.homesick/repos/dotfiles/home/.vim/" . (<q-bang> ==# '!' ? "after/" : "") . "ftplugin/" . (<q-args> ==# '' ? &filetype : <q-args>) . ".vim"

" Use Vim's builtin help easily {{{2
" ----------------------------------
set keywordprg=:help

" Load ctags from git dir {{{2
" ----------------------------
set tags^=./.git/tags;

" When in a terminal, use parent vim as editor {{{2
" -------------------------------------------------
if has ('nvim') && executable('nvr')
  let $EDITOR = 'nvr -cc split --remote-wait'
  let $VISUAL = $EDITOR
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
endif

]]

-- modeline {{{1
-- vim: set foldmethod=marker et sw=2 sts=2:

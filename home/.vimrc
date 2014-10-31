" Vundle configuration {{{1
" =========================

" Initialization {{{2
" -------------------

" install vundle if not yet installed
if ! filereadable(expand("~/.vim/bundle/vundle/.git/HEAD"))
  let s:first_run=1
  !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
endif

filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" }}}

" Plug-in list
" ------------
" Github repositories
Plugin 'gmarik/vundle'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-speeddating'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sjl/gundo.vim'
Plugin 'sjl/AnsiEsc.vim'
Plugin 'pydave/renamer.vim'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'junegunn/vim-easy-align'
Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'tommcdo/vim-exchange'
Plugin 'rking/ag.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'michamos/vim-arxivist'
" vim-scripts repos
Plugin 'matchit.zip'
" External git repo
" Plugin 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

" More initialization {{{2
" ------------------------
" install all bundles on first run
if exists("s:first_run")
  BundleInstall
  echomsg "Restart Vim for the plugins to be available"
endif
call vundle#end()
" enable ftplugins
filetype plugin indent on
" }}}

" Mappings {{{1
" =============

"Use a more accessible key as <Leader>, <Space> is redundant by default
let mapleader = "\<Space>"
" remap keyboard to use the bépo layout (http://www.bepo.fr)
runtime bepo.vim

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
noremap <Leader># :ls<CR>:b<space>
noremap <Leader>' :marks<CR>
noremap <Leader>" :registers<CR>

" easily change buffers
noremap <Leader>b :bprevious<CR>
noremap <Leader>é :bnext<CR>

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
noremap C ^
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

"Open the Arxivist journal
noremap <Leader>a :Arxivist<CR>

" Plug-ins configuration {{{1
" ===========================

" gundo {{{2
" ----------
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
autocmd! BufWritePost * if &filetype=='tex' | silent call LatexBox_Latexmk(0) | endif
if has("macunix")
  let g:LatexBox_viewer="open -a Skim"
elseif has("unix") "assuming linux if not OSX
  let g:LatexBox_viewer="xdg-open"
endif
let g:LatexBox_show_warnings=1 "also show warnings
let g:LatexBox_ignore_warnings=['Underfull', 'Overfull', 'specifier changed to', 'defernumbers']
let g:LatexBox_Folding=1
let g:LatexBox_latexmk_options="-pdflatex='pdflatex -synctex=1 \%O \%S'"
let g:LatexBox_latexmk_async=1
let g:LatexBox_quickfix=2 "do not jump to quickfix window

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
vmap x <Plug>(Exchange)
nmap lxc <Plug>(ExchangeClear)
nmap lxx <Plug>(ExchangeLine)

" vim-commentary {{{2
" -------------------
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>Commentary_

" ag.vim {{{2
" -----------
let g:ag_apply_lmappings = 0
let g:ag_apply_qmappings = 0


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
" Style {{{1
" ----------
if has("gui_running") || exists("$TERM_PROGRAM") && $TERM_PROGRAM ==# "iTerm.app"
  colorscheme solarized
endif
if has("gui_running")
  set guioptions-=T " no buttons nor menus
  set guioptions-=m
  if has("gui_gtk2")
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
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

" auto reload file if changed externally and buffer not modified {{{2
" -------------------------------------------------------------------
set autoread

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
if exists("s:first_run")
  execute "mkspell " . &spellfile
endif

" source the .vimrc file on save to apply all changes immediately {{{2
" --------------------------------------------------------------------
autocmd! BufWritePost .vimrc source ~/.vimrc | AirlineRefresh

" edit dotfiles easily {{{2
" -------------------------
noremap <Leader>ed :split ~/.homesick/repos/dotfiles/home/<CR>
noremap <Leader>ev :split ~/.homesick/repos/dotfiles/home/.vimrc<CR>

" Use Vim's builtin help easily {{{2
" ----------------------------------
set keywordprg=:help

" modeline {{{1
" vim: set foldmethod=marker et sw=2 sts=2:

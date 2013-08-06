" Vundle configuration {{{1
" =========================

" install vundle if not yet installed
if ! filereadable(expand("~/.vim/bundle/vundle/.git/HEAD"))
  let s:first_run=1
  !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
endif

filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Plug-in list {{{2
" -----------------
" Github repositories
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-commentary'
Bundle 'SirVer/ultisnips'
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'sjl/gundo.vim'
Bundle 'sjl/AnsiEsc.vim'
Bundle 'pydave/renamer.vim'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'godlygeek/tabular'
"Forked versions
Bundle 'michamos/tagbar'
Bundle 'michamos/vim-powerline'
" vim-scripts repos
Bundle 'matchit.zip'
" External git repo
" Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
" }}}
" install all bundles on first run
if exists("s:first_run")
  BundleInstall
  echomsg "Restart Vim for the plugins to be available"
endif
" enable ftplugins
filetype plugin indent on

" Mappings {{{1
" =============

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
noremap <Leader>b :ls<CR>:b<space>
noremap <Leader>' :marks<CR>
noremap <Leader>" :registers<CR>

" toggle the display of hidden characters (in 'listchars')
noremap <silent> <Leader>lc :set list!<CR>

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

" powerline {{{2
" --------------
set laststatus=2
let g:Powerline_symbols='fancy'

" fugitive {{{2
" -------------
noremap <Leader>g :Gstatus<CR>

" latex {{{2
" ----------
" Latex-suite settings, not used any more {{{3 "
"set grepprg=grep\ -nH\ $*
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Imap_UsePlaceHolders=0 " on utilise ultisnips
"" compilation automatique à chaque écriture du buffer
"autocmd! BufWritePost *.tex silent call Tex_RunLaTeX()
"" disable replacing of "é" with "\item"
"imap <buffer> <Plug>deactivated_tex_item <Plug>Tex_InsertItemOnThisLine
" 3}}} "
let g:tex_flavor='latex'
autocmd! BufWritePost *.tex silent call LatexBox_Latexmk(0)
if has("macunix")
  let g:LatexBox_viewer="open -a Skim"
elseif has("unix") "assuming linux if not OSX
  let g:LatexBox_viewer="xdg-open"
endif
"let g:LatexBox_show_warnings=0 "don't show compilation warnings, only errors
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

" Style {{{1
" ----------
if has("gui_running")
  colorscheme solarized
  let g:Powerline_colorscheme='solarized'
  set guioptions-=Tm " no buttons nor menus
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
  PowerlineReloadColorscheme
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
noremap <silent> <Leader>n :nohlsearch<CR>

" error displayed visually {{{2
" -----------------------------
set visualbell

" status {{{2
" -----------
"set relativenumber
set ruler
set showcmd "show incomplete commands

" conceal characters, especially nice for TeX {{{2
" ------------------------------------------------
set conceallevel=2

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
autocmd! BufWritePost .vimrc source ~/.vimrc | PowerlineReloadColorscheme

" edit dotfiles easily {{{2
" -------------------------
noremap <Leader>ed :split ~/.homesick/repos/dotfiles/home/<CR>
noremap <Leader>ev :split ~/.homesick/repos/dotfiles/home/.vimrc<CR>
" modeline {{{1
" vim: set foldmethod=marker et sw=2 sts=2:

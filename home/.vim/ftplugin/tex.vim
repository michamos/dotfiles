" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
setl sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setl iskeyword+=:

" do not break lines in the middle of words
setl linebreak

" forward search
map <silent> <buffer> <Leader>ls :silent !~/bin/pdfviewer
		\ "<C-R>=b:vimtex.out()<CR>" <C-R>=line('.')<CR> "%:p" <CR>

" change clashing default mappings
nmap <silent> <buffer> <leader>* <plug>(vimtex-env-toggle-star)
nmap <silent> <buffer> <leader>% <plug>(vimtex-delim-toggle-modifier)
nmap <silent> <buffer> lse <plug>(vimtex-change-env)
nmap <silent> <buffer> lsc <plug>(vimtex-change-cmd)
" define yse, yse mappings, see vimtex-faq-surround
let b:surround_{char2nr("e")}
  \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"

" correct common mistakes
iabbrev <buffer> i.e. i.e.\
iabbrev <buffer> e.g. e.g.\
iabbrev <buffer> lamdba lambda


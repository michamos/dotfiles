" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
setl sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
setl iskeyword+=:

"forward search
map <silent> <Leader>ls :silent !~/bin/pdfviewer
		\ "<C-R>=LatexBox_GetOutputFile()<CR>" <C-R>=line('.')<CR> "%:p" <CR>


" remove sub/superscripts replacement with conceal
let g:tex_conceal='adgm'

" Latex-suite settings, not used anymore
" --------------------------------------
"
"" compile pdf with synctex support and add support for external viewer (Skim)
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_CompileRule_pdf="pdflatex -interaction=nonstopmode -synctex=1 $*"
"let g:Tex_ViewRule_pdf="$HOME/bin/pdfviewer"
"let g:Tex_TreatMacViewerAsUNIX=1
"
"" fix behaviour of quickfix
"let g:Tex_GotoError=0
"" disable replacing of "Ã©" with "\item"
"imap <buffer> <Plug>deactivated_tex_item <Plug>Tex_InsertItemOnThisLine
"" keymap to compile bibtex
"noremap <buffer> <Leader>lb :!bibtex %:t:r.aux<CR>

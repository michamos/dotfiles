return {
'tpope/vim-sensible',
'tpope/vim-repeat',
'tpope/vim-surround',
'tpope/vim-eunuch',
{ 'tpope/vim-fugitive',
lazy = false,
keys = {
	{ '<Leader>g', vim.cmd.Git },
},
init = function() vim.g.fugitive_git_executable = 'LANG=en git' end,  --fugitive is not so good with translations
},
'tpope/vim-rhubarb',
'tpope/vim-markdown',
'tpope/vim-git',
'tpope/vim-dispatch',
'tpope/vim-sleuth',
'tpope/vim-vinegar',
'tpope/vim-speeddating',
'tpope/vim-afterimage',
{ 'SirVer/ultisnips' , init = function()
		vim.g.UltiSnipsEditSplit="horizontal"
		-- use <C-{t,s}> to jump between snippet insertions
		vim.g.UltiSnipsJumpForwardTrigger="<C-t>"
		vim.g.UltiSnipsJumpBackwardTrigger="<C-s>"
end,
},
'honza/vim-snippets',
{ 'mbbill/undotree', keys = {
	{  '<Leader>u', vim.cmd.UndotreeToggle },
}
},
'sjl/AnsiEsc.vim',
{ 'lervag/vimtex', ft = 'tex' , init = function()
	vim.g.tex_flavor='latex'
	-- remove sub/superscripts replacement with conceal
	vim.g.tex_conceal='abdgm'
	vim.g.vimtex_compiler_method='latexrun'
	-- vim.g.vimtex_latexmk_continuous=0
	-- vim.g.vimtex_latexmk_background=1
	-- vim.g.vimtex_latexmk_options="-pdflatex='pdflatex -synctex=1 \\%O \\%S'"
	vim.g.vimtex_view_method = 'zathura'
	vim.g.vimtex_imaps_leader='’'
end,
},
{ 'vim-airline/vim-airline' , init = function() vim.g.airline_powerline_fonts = 1 end },
'vim-airline/vim-airline-themes',
{ 'tommcdo/vim-exchange',
init = function() vim.g.exchange_no_mappings = true end,
keys = {
	{'lx', '<Plug>(Exchange)', mode = 'n'},
	{'X', '<Plug>(Exchange)', mode = 'x'},
	{'lxc', '<Plug>(ExchangeClear)', mode = 'n'},
	{'lxx', '<Plug>(ExchangeLine)', mode = 'n'},
}
},
{ 'mhinz/vim-grepper' , init = function()
	vim.g.grepper = { tools = {'rg', 'git', 'grep'} }
end,
},
'chrisbra/csv.vim',
{ 'vim-pandoc/vim-pandoc', init = function()
	vim.g['pandoc#folding#fdc'] = 0
	vim.g['pandoc#keyboard#display_motions'] = 0
end,
},
'vim-pandoc/vim-pandoc-syntax',
'michamos/vim-bepo',
'davidhalter/jedi-vim',
'hynek/vim-python-pep8-indent',
'jmcantrell/vim-virtualenv',
'junegunn/vim-peekaboo',
'ledger/vim-ledger',
'dense-analysis/ale',
'vim-scripts/matchit.zip',
'leafgarland/typescript-vim',
'vim-python/python-syntax',
{ 'diepm/vim-rest-console' ,
init = function()
	vim.g.vrc_set_default_mapping = 0
	vim.g.vrc_curl_opts = {
		 ['-sSi'] = '',
		}
	vim.api.nvim_create_user_command('HTTPRequest', 'call VrcQuery()', {})
end,
ft = 'rest',
},
'tsandall/vim-rego',
'cespare/vim-toml',
}
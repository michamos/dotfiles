return {
	'tpope/vim-repeat',
	'tpope/vim-surround',
	'tpope/vim-eunuch',
	{
		'tpope/vim-fugitive',
		lazy = false,
		keys = {
			{ '<Leader>g', vim.cmd.Git },
		},
		init = function() vim.g.fugitive_git_executable = 'LANG=en git' end, --fugitive is not so good with translations
	},
	'tpope/vim-rhubarb',
	'tpope/vim-git',
	'tpope/vim-sleuth',
	'tpope/vim-speeddating',
	'tpope/vim-afterimage',
	{
		'mbbill/undotree',
		keys = {
			{ '<Leader>u', vim.cmd.UndotreeToggle },
		}
	},
	{
		'lervag/vimtex',
		ft = 'tex',
		init = function()
			vim.g.tex_flavor = 'latex'
			-- remove sub/superscripts replacement with conceal
			vim.g.tex_conceal = 'abdgm'
			vim.g.vimtex_compiler_method = 'latexrun'
			-- vim.g.vimtex_latexmk_continuous=0
			-- vim.g.vimtex_latexmk_background=1
			-- vim.g.vimtex_latexmk_options="-pdflatex='pdflatex -synctex=1 \\%O \\%S'"
			vim.g.vimtex_view_method = 'zathura'
			vim.g.vimtex_imaps_leader = '’'
		end,
	},
	'tommcdo/vim-exchange',
	'chrisbra/csv.vim',
	'hynek/vim-python-pep8-indent',
	'ledger/vim-ledger',
	{
		'diepm/vim-rest-console',
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
}

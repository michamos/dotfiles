return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
		},
		config = function()
			require('telescope').setup()
			require('telescope').load_extension('fzf')
		end,
		keys = {
			{ '<leader>ff', '<Cmd>Telescope find_files<CR>',  desc = 'Telescope find files' },
			{ '<leader>fg', '<Cmd>Telescope live_grep<CR>',  desc = 'Telescope live grep' },
			{ '<leader>fb', '<Cmd>Telescope buffers<CR>',  desc = 'Telescope buffers' },
			{ '<leader>fh', '<Cmd>Telescope help_tags<CR>',  desc = 'Telescope help tags' },
		},
	},
}

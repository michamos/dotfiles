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
			{ '<leader>f', '<Cmd>Telescope find_files hidden=true<CR>',  desc = 'Telescope find files' },
			{ '<leader>r', '<Cmd>Telescope live_grep<CR>',  desc = 'Telescope live grep' },
			{ '<leader>b', '<Cmd>Telescope buffers<CR>',  desc = 'Telescope buffers' },
			{ '<leader>\'', '<Cmd>Telescope marks<CR>',  desc = 'Telescope marks' },
			{ '<leader>"', '<Cmd>Telescope registers<CR>',  desc = 'Telescope registers' },
			{ '<leader>h', '<Cmd>Telescope help_tags<CR>',  desc = 'Telescope help tags' },
		},
		cmd = 'Telescope',
	},
}

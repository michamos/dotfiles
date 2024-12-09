return {
	{
		"ishan9299/nvim-solarized-lua",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd [[ colorscheme solarized ]]
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = { highlight = 'Comment' , char = "▏"},
			scope = { highlight = 'Text', char = "▎" },
		},
	},
	{
		'stevearc/oil.nvim',
		lazy = false,
		keys = {
			{'-', vim.cmd.Oil},
		},
		opts = {},
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ 'nvim-tree/nvim-web-devicons', lazy = true },
}

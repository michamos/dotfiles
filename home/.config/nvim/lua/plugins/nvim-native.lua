return {
	{
		"ishan9299/nvim-solarized-lua",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			IblIndent = { link = "Whitespace" },
			IblScope = { link = "Text" },
		},
		config = function(_, opts)
			vim.cmd.colorscheme("solarized")
			for name, val in pairs(opts) do
				vim.api.nvim_set_hl(0, name, val)
			end
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = { char = "▏" },
			scope = { char = "▎" },
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
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = true
		},
	},
	{ 'nvim-tree/nvim-web-devicons', lazy = true },
	{
		'epwalsh/obsidian.nvim',
		version = "*",  -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		opts = {
			ui = { enable = false },
			workspaces = {
				{
					name = "work",
					path = "~/cernbox/vaults/work",
				},
			},
		},
	}
}


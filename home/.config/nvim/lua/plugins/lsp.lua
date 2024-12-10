return {
	"williamboman/mason.nvim",
	{ 
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "pyright", "ruff", "lua_ls" }
		}
	},
	"neovim/nvim-lspconfig",
}


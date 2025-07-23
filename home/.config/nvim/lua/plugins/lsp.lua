local on_attach = function(client, bufnr)
	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
end

local augroup = vim.api.nvim_create_augroup('lsp', { clear = true })
vim.api.nvim_create_autocmd({'LspAttach'}, {
	group = augroup,
	callback = function()
		vim.keymap.set('n', 'S', vim.lsp.buf.hover, { buffer = true })
	end,
	desc = 'Define LSP-powered mappings',
})

vim.keymap.set("n", "wd", "<C-w>d", { desc = "Show LSP diagnostics", remap = true })

return {
	"SmiteshP/nvim-navic",
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			pyright = {},
			ruff = {},
			lua_ls = {},
			tinymist = {},
		},
		ft = { "lua", "python" },
		config = function(_, opts)
			local ensure_installed = {}
			for server_name, _ in pairs(opts) do
				table.insert(ensure_installed, server_name)
			end
			require("mason-lspconfig").setup {
				ensure_installed = ensure_installed,
				automatic_enable = true,
			}
			for server_name, server_opts in pairs(opts) do
				server_opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
				server_opts.on_attach = on_attach
				vim.lsp.config(server_name, server_opts)
			end
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- optional cmp completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
}

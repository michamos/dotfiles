local function lua_ls_on_init(client)
	if client.workspace_folders then
		local path = client.workspace_folders[1].name
		if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
			return
		end
	end

	client.config.settings.Lua = {
		runtime = {
			-- Tell the language server which version of Lua you're using
			-- (most likely LuaJIT in the case of Neovim)
			version = 'LuaJIT'
		},
		-- Make the server aware of Neovim runtime files
		workspace = {
			checkThirdParty = false,
			library = {
				vim.env.VIMRUNTIME
				-- Depending on the usage, you might want to add additional paths here.
				-- "${3rd}/luv/library"
				-- "${3rd}/busted/library",
			}
			-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
			-- library = vim.api.nvim_get_runtime_file("", true)
		}
	}
end

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
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
		},
		opts = {
			pyright = {},
			ruff = {},
			lua_ls = { on_init = lua_ls_on_init },
		},
		ft = { "lua", "python" },
		config = function(_, opts)
			require("mason").setup()
			local ensure_installed = {}
			for server_name, _ in pairs(opts) do
				table.insert(ensure_installed, server_name)
			end
			require("mason-lspconfig").setup {
				ensure_installed = ensure_installed,
			}
			for server_name, server_opts in pairs(opts) do
				server_opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
				server_opts.on_attach = on_attach
				require("lspconfig")[server_name].setup(server_opts)
			end
		end,
	},
}

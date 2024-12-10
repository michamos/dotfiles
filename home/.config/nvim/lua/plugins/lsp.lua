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

local augroup = vim.api.nvim_create_augroup('lsp', { clear = true })
vim.api.nvim_create_autocmd({'LspAttach'}, {
  group = augroup,
  callback = function()
	vim.keymap.set('n', 'S', vim.lsp.buf.hover, { buffer = true })
  end,
  desc = 'Define LSP-powered mappings',
})

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup {
				ensure_installed = { "pyright", "ruff", "lua_ls" },
			}
			local lsp = require("lspconfig")
			lsp.pyright.setup {}
			lsp.ruff.setup {}
			lsp.lua_ls.setup { on_init = lua_ls_on_init }
		end,
	},
}

return {
	{ 'hrsh7th/cmp-buffer',   lazy = true },
	{ 'hrsh7th/cmp-nvim-lsp', lazy = true },
	'hrsh7th/cmp-nvim-lsp-signature-help',
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup {
				snippet = { expand = function(args) vim.snippet.expand(args.body) end, },
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer" },
				}
			}
		end,
	},
}

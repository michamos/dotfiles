local trailing_whitespace = function()
	local symbol = "␣ "
	local space = vim.fn.search([[\s\+$]], 'nwc')
	return space ~= 0 and symbol..space or ""
end

local mixed_indent = function()
	local symbol = '⇥␣ '
	local space_pat = [[\v^ +]]
	local tab_pat = [[\v^\t+]]
	local space_indent = vim.fn.search(space_pat, 'nwc')
	local tab_indent = vim.fn.search(tab_pat, 'nwc')
	local mixed = (space_indent > 0 and tab_indent > 0)
	local mixed_same_line
	if not mixed then
		mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
		mixed = mixed_same_line > 0
	end
	if not mixed then return '' end
	if mixed_same_line ~= nil and mixed_same_line > 0 then
		return symbol..mixed_same_line
	end
	local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
	local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
	if space_indent_cnt > tab_indent_cnt then
		return  symbol..tab_indent
	else
		return symbol..space_indent
	end
end

return {
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			theme = "solarized_light",
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
					"diagnostics",
				},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding",
					"fileformat",
					"filetype",
					{ trailing_whitespace, color = "DiffDelete" },
					{ mixed_indent, color = "DiffDelete" },
				},
				lualine_y = { "progress" },
			},
			extensions = {"fugitive", "lazy", "man", "oil"}
		},
	},
}

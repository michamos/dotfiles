return {
	'majutsushi/tagbar',
	keys = {{ '<Leader>t', vim.cmd.TagbarToggle, silent = true }},
	init = function()
		vim.g.tagbar_autofocus = 1
		vim.g.tagbar_autoclose = 1
		vim.g.tagbar_map_togglesort = "k"
		vim.g.tagbar_type_bib = {
		       ctagstype = 'bibtex',
		       kinds = { 'b:bibitems' }
		       }
	       end,
}

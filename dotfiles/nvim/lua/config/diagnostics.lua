vim.diagnostic.config({
	undeline = true,
	severity_sort = true,
	update_in_insert = false,
	virtual_text = { true, current_line = false }, -- end of line text
	virtual_lines = { current_line = true }, -- underneath line text
})

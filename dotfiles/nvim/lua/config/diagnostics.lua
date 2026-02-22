vim.diagnostic.config({
	undeline = true,
	severity_sort = true,
	update_in_insert = false,
	virtual_text = { true, current_line = false }, -- end of line text
	-- virtual_lines = { current_line = true }, -- underneath line text
})

local my_diagnostics = vim.api.nvim_create_augroup("MyDiagnostics", {})
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.diagnostic.enable(false)
	end,
	group = my_diagnostics,
})
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.diagnostic.enable(true)
	end,
	group = my_diagnostics,
})
vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
	callback = function()
		local opts = {
			focusable = false,
			scope = "cursor",
			close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
		}
		vim.diagnostic.open_float(nil, opts)
	end,
	group = my_diagnostics,
})

-- TODO: setup diagnostics + dap.lua
vim.diagnostic.config({
	undeline = true,
	severity_sort = true,
	update_in_insert = false,
	float = { border = "rounded", source = true },
	virtual_text = true, -- end of line text
	virtual_linex = false, -- underneath line text
	-- auto open float with [d and ]d
	jump = { float = true },
})

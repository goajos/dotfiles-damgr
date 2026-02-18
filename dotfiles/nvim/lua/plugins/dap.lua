vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
})
local d = require("dap")
require("nvim_dap_virtual_text").setup()

d.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-dap",
	name = "lldb",
}
d.configurations.c = {
	c = {
		name = "launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cmd = "${workspaceFolder}",
		args = {
			-- "init",
			"merge",
			-- "update",
		},
	},
	python = {
		name = "launch",
		type = "python",
		request = "launch",
		program = "${file}",
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}

vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#ff0000" })
vim.fn.sign_define("DapBreakpoint", { text = "o", texthl = "DapBreakpointColor", numhl = "" })

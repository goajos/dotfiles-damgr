vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
})
require("nvim-dap-virtual-text").setup({})

local d = require("dap")
d.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-dap",
	name = "lldb",
}
d.configurations.c = {
	{
		name = "launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		args = {
			-- "init",
			"merge",
			-- "update",
		},
	},
}

d.adapters.python = {
	type = "executable",
	command = function()
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			return cwd .. "/.venv/bin/python"
		else
			return "/usr/bin/python"
		end
	end,
	args = { "-m", "debugpy.adapter" },
	options = {
		source_filetype = "pyhon",
	},
}
d.configurations.python = {
	{
		name = "launch",
		type = "python",
		request = "launch",
		program = "${file}",
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}

d.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8080 })
end
d.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "launch",
	},
}

vim.api.nvim_set_hl(0, "DapBreakpointColor", { fg = "#ff0000" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", numhl = "" })

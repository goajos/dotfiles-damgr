local m = vim.keymap.set
local opts = { noremap = true, silent = true }

-- cycle tabs
m("n", "<tab>", ":bnext<cr>", { desc = "Next buffer" })
m("n", "<s-tab>", ":bprevious<cr>", { desc = "Previous buffer" })

m("n", "<leader>#", "<cmd>e #<cr>", { desc = "Goto last edited" })

m("n", "<c-h>", "<c-w>h", { remap = true })
m("n", "<c-j>", "<c-w>j", { remap = true })
m("n", "<c-k>", "<c-w>k", { remap = true })
m("n", "<c-l>", "<c-w>l", { remap = true })

-- <c-w>c = close window (not buffer!)
-- <c-w>p = previous window

m("n", "gl", "$", { desc = "Goto end of line" })
m("n", "gh", "$", { desc = "Goto start of line" })

m("n", "<leader>/", "<cmd>nohlsearch<cr>")

m({ "n", "x" }, "gy", '"+y', { desc = "Yank to system clipboard" })
m({ "n", "x" }, "gp", '"+p', { desc = "Paste from system clipboard" })

-- indent and stay in visual mode
m("v", "<", "<gv")
m("v", ">", ">gv")

m("t", "<esc>", "<c-\\><c-n>", { desc = "Leave terminal buffer insert mode" })
m("t", "<c-v><esc>", "<esc>", { desc = "Send <Esc> to terminal buffer" })

-- dap debug
local sidebar_is_open = false
local cur_sidebar
local toggle_dap_sidebar = function()
	if sidebar_is_open then
		cur_sidebar.close()
		sidebar_is_open = false
	else
		local widgets = require("dap.ui.widgets")
		cur_sidebar = widgets.sidebar(widgets.scopes)
		cur_sidebar.open()
		sidebar_is_open = true
	end
end
vim.keymap.set("n", "<Leader>d", toggle_dap_sidebar, { desc = "Toggle the dap sidebar" })
local repl_is_open = false
local repl
local toggle_dap_repl = function()
	if repl_is_open then
		repl.close()
		repl_is_open = false
	else
		repl = require("dap.repl")
		repl.open()
		repl_is_open = true
	end
end
vim.keymap.set("n", "<Leader>r", toggle_dap_repl, { desc = "Toggle the dap repl" })
vim.keymap.set("n", "<F5>", ":DapContinue<CR>", { desc = "Continue the dap debugger" })
vim.keymap.set("n", "<F17>", ":DapTerminate<CR>", { desc = "Terminate the dap debugger" })
vim.keymap.set("n", "<F9>", ":DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint on current line" })
vim.keymap.set("n", "<F10>", ":DapStepOver<CR>", { desc = "Step over" })
vim.keymap.set("n", "<F11>", ":DapStepInto<CR>", { desc = "Step into" })
vim.keymap.set("n", "<F23>", ":DapStepOut<CR>", { desc = "Step out" })

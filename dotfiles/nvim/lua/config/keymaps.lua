local m = vim.keymap.set
local _opts = { noremap = true, silent = true }

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

m("n", "<leader>f", ":find ", { desc = "Toggle find" })
m("n", "<leader>g", ":grep ", { desc = "Toggle grep" })

local chat_is_open = false
local toggle_copilot_chat = function()
  if chat_is_open then
    vim.cmd("CopilotChatClose")
    chat_is_open = false
  else
    vim.cmd("CopilotChat")
    chat_is_open = true
  end
end
m("n", "<leader>c", toggle_copilot_chat, { desc = "Toggle copilot chat" })

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
m("n", "<leader>d", toggle_dap_sidebar, { desc = "Toggle the dap sidebar" })
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
m("n", "<leader>r", toggle_dap_repl, { desc = "Toggle the dap repl" })
m("n", "<f5>", ":DapContinue<cr>", { desc = "Continue the dap debugger" })
m("n", "<f17>", ":DapTerminate<cr>", { desc = "Terminate the dap debugger" })
m("n", "<f9>", ":DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint on current line" })
m("n", "<f10>", ":DapStepOver<cr>", { desc = "Step over" })
m("n", "<f11>", ":DapStepInto<cr>", { desc = "Step into" })
m("n", "<f23>", ":DapStepOut<cr>", { desc = "Step out" })

-- cycle buffers of active tabline
local next_buffer = function()
  local active_tab = vim.fn.tabpagenr()
  local buffers = _G.tabline_buffers[active_tab]

  if not buffers or #buffers == 0 then return end

  local active_buf = vim.api.nvim_get_current_buf()
  -- lua tables are 1 based, fn.index is 0 based and and can return -1
  local idx = (vim.tbl_contains(buffers, active_buf) and vim.fn.index(buffers, active_buf) or 0) + 1
  local next_idx = (idx == #buffers) and 1 or (idx + 1)

  vim.api.nvim_set_current_buf(buffers[next_idx])
end
-- m("n", "<tab>", ":bnext<cr>", { desc = "Next buffer" })
m("n", "<tab>", next_buffer, { desc = "Next buffer" })
local prev_buffer = function()
  local active_tab = vim.fn.tabpagenr()
  local buffers = _G.tabline_buffers[active_tab]

  if not buffers or #buffers == 0 then return end

  local active_buf = vim.api.nvim_get_current_buf()
  -- lua tables are 1 based, fn.index is 0 based and and can return -1
  local idx = (vim.tbl_contains(buffers, active_buf) and vim.fn.index(buffers, active_buf) or 0) + 1
  local prev_idx = (idx == 1) and #buffers or (idx - 1)

  vim.api.nvim_set_current_buf(buffers[prev_idx])
end
-- m("n", "<s-tab>", ":bprevious<cr>", { desc = "Previous buffer" })
m("n", "<s-tab>", prev_buffer, { desc = "Previous buffer" })

local m    = vim.keymap.set
local opts = { noremap = true, silent = true  }

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

m({"n", "x"}, "gy", '"+y', { desc="Yank to system clipboard" })
m({"n", "x"}, "gp", '"+p', { desc="Paste from system clipboard" })

-- indent and stay in visual mode
m("v", "<", "<gv")
m("v", ">", ">gv")

m("t", "<esc>", "<c-\\><c-n>", { desc = "Leave terminal buffer insert mode" })
m("t", "<c-v><esc>", "<esc>", { desc = "Send <Esc> to terminal buffer" })

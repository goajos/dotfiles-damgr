vim.g.mapleader       = " "
vim.g.maplocalleader  = " " 
vim.g.netrw_liststyle = 3
vim.g.have_nerd_font  = true

vim.o.termguicolors = true
-- blinking cursor in insert mode
vim.opt.guicursor     = "n-v-c-sm:block"
vim.opt.guicursor:append("r-cr-o:hor20")
vim.opt.guicursor:append("i-ci-ve-t:block-blinkwait0-blinkon500-blinkoff500-TermCursor")

vim.o.number         = true
vim.o.relativenumber = true

vim.o.cursorline = true
vim.o.signcolumn = "number"

vim.o.mouse = "a" --enable mouse for resizing

vim.o.shiftwidth  = 2
vim.o.tabstop     = 2
vim.o.softtabstop = 2
vim.o.expandtab   = true
vim.o.breakindent = true

vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup   = false

vim.keymap.set("n", "<leader>/", "<cmd>nohlsearch<cr>")
vim.o.ignorecase = true
vim.o.smartcase  = true
vim.o.inccommand = "split" -- live substitution with (%)s

vim.o.updatetime = 1000 -- decrease update time

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.scrolloff = 10

vim.o.confirm = true -- raise dialog for confirmation

vim.keymap.set({"n", "x"}, "gy", '"+y', { desc="Yank to system clipboard" })
vim.keymap.set({"n", "x"}, "gp", '"+p', { desc="Paste from system clipboard" })



-- grn = rename symbol
-- gra = code actions
-- grr = find references
-- gri = go to implementation
-- grt = go to type definition
-- gO  = document symbols

local m = vim.keymap.set

m("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
m("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })

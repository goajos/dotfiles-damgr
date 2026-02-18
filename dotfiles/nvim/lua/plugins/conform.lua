-- TODO: how to handle package updates?
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
  formatters_by_ft = {
    c = { "clang-format" },
    lua = { "stylua" },
    python = { "ruff", "black" },
  },
  format_on_save  = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"


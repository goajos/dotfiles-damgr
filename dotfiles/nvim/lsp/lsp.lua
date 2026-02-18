-- grn = rename symbol
-- gra = code actions
-- grr = find references
-- gri = go to implementation
-- grt = go to type definition
-- gO  = document symbols

local lsp_keymaps = {
  { keys = "K", func = vim.lsp.buf.hover, desc = "Hover documentation", has = "hoverProvider" },
  { keys = "gd", fumc = vim.lsp.buf.definition, desc = "Goto definition", has = "definitionProvider" },
}

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true  })
end

local completion = vim.g.completion_mode or "native"
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local buf = event.buf
    if client then
      if completion == "native" and client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
      end

      if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
      end

      for _, km in ipairs(lsp_keymaps) do
        if not km.has or client.server_capabilities[km.has] then
          vim.keymap.set(
            "n",
            km.keys,
            km.func,
            { buffer = buf, desc = "LSP: " .. km.desc }
          )
        end
      end
    end
  end
})

vim.lsp.enable({
  "clang",
  "lua_ls"
})

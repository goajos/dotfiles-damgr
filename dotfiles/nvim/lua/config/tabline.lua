-- TODO: tabnew brings one tab and only opens tab 2, no tab 3
local M = {}

function M.set_highlights()
  vim.api.nvim_set_hl(0, "MyBufInactive", {})
  vim.api.nvim_set_hl(0, "MyBufActive", { bold = true })
end

local function get_display_name(path)
  if path == "" then
    return "[NO_NAME]"
  end
  local parts = vim.split(path, "/", { plain = true })
  if #parts == 1 then
    return parts[1]                                  -- just filename if no parent
  elseif #parts == 2 then
    return parts[#parts - 1] .. "/" .. parts[#parts] -- parent/filename
  else
    -- return "grandparent/parent/filename" (last 3 parts)
    return parts[#parts - 2] .. "/" .. parts[#parts - 1] .. "/" .. parts[#parts]
  end
end

local function remove_buf_from_tab(active_buf, tab)
  for bufnr, buf in ipairs(_G.tabline_buffers[tab]) do
    if buf == active_buf then
      table.remove(_G.tabline_buffers[tab], bufnr)
    end
  end
end

local function remove_buf_from_tabs(active_buf)
  for tab = 1, vim.fn.tabpagenr("$") do
    for bufnr, buf in ipairs(_G.tabline_buffers[tab]) do
      if buf == active_buf then
        table.remove(_G.tabline_buffers[tab], bufnr)
        break
      end
    end
  end
end

local function update_tabline_buffers()
  local active_tab = vim.fn.tabpagenr()

  if not _G.tabline_buffers[active_tab] then
    _G.tabline_buffers[active_tab] = {}
    vim.keymap.set("n", "<leader>" .. active_tab, function()
      vim.cmd("tabnext " .. active_tab)
    end, { desc = "Goto tab " .. active_tab })
  end

  local active_buf = vim.api.nvim_get_current_buf()
  for tab = 1, vim.fn.tabpagenr("$") do
    if tab ~= active_tab and _G.tabline_buffers[tab] then
      remove_buf_from_tab(active_buf, tab)
    end
  end

  if not vim.tbl_contains(_G.tabline_buffers[active_tab], active_buf) then
    table.insert(_G.tabline_buffers[active_tab], active_buf)
  end
end

_G.tabline_buffers = {}
function _G.tabline()
  local active_tab = vim.fn.tabpagenr()
  local active_buf = vim.api.nvim_get_current_buf()
  local buffers = { active_tab .. ": " }

  if _G.tabline_buffers[active_tab] then
    for _, buf in ipairs(_G.tabline_buffers[active_tab]) do
      local buf_name = vim.api.nvim_buf_get_name(buf)
      local buf_display_name = get_display_name(buf_name)

      if buf == active_buf then
        table.insert(buffers, table.concat({
          "%#MyBufActive# ",
          buf_display_name,
          "",
        }))
      else
        table.insert(buffers, table.concat({
          "%#MyBufInactive# ",
          buf_display_name,
          "",
        }))
      end
    end
  end

  if #buffers == 0 then
    return ""
  end

  local tabline = table.concat(buffers)

  return tabline
end

function M.setup()
  M.set_highlights()

  vim.api.nvim_create_augroup("MyTabline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = "MyTabline",
    callback = M.set_highlights,
  })
  vim.api.nvim_create_autocmd({ "TabEnter", "BufEnter" }, {
    group = "MyTabline",
    callback = update_tabline_buffers
  })
  vim.api.nvim_create_autocmd("TabClosed", {
    group = "MyTabline",
    callback = function()
      for tabline = 1, #_G.tabline_buffers do
        pcall(vim.keymap.del, "n", "<leader>" .. tabline)
      end

      local tabs = vim.api.nvim_list_tabpages()
      for idx, _ in ipairs(tabs) do
        vim.keymap.set("n", "<leader>" .. idx, function()
          vim.cmd("tabnext " .. idx)
        end, { desc = "Goto tab " .. idx })
      end
    end
  })
  vim.api.nvim_create_autocmd("BufDelete", {
    group = "MyTabline",
    callback = function(cargs)
      remove_buf_from_tabs(cargs.buf)
    end
  })

  vim.opt.showtabline = 2
  vim.opt.tabline = "%!v:lua.tabline()"
end

M.setup()

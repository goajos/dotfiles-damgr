-- TODO: set up sync with git-prompt.sh?
local M = {}

local function get_icon()
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return ""
	end
	local f = vim.fn.expand("%:t")
	local e = vim.fn.expand("%:e")
	local icon = devicons.get_icon(f, e, { default = true })
	return icon and (icon .. " ") or ""
end

local function get_diagnostics()
	if not vim.diagnostic then
		return ""
	end
	local d = vim.diagnostic.get(0)
	local e, w, i, h = 0, 0, 0, 0
	for _k, v in ipairs(d) do
		if v.severity == vim.diagnostic.severity.ERROR then
			e = e + 1
		elseif v.severity == vim.diagnostic.severity.WARN then
			w = w + 1
		elseif v.severity == vim.diagnostic.severity.INFO then
			i = i + 1
		elseif v.severity == vim.diagnostic.severity.HINT then
			h = h + 1
		end
	end
	local st = ""
	if e > 0 then
		st = st .. "e:" .. e .. " "
	end
	if w > 0 then
		st = st .. "w:" .. w .. " "
	end
	if i > 0 then
		st = st .. "i:" .. i .. " "
	end
	if h > 0 then
		st = st .. "h:" .. h .. " "
	end
	return st
end

function M.build()
	local st = ""

	local fnm = vim.fn.expand("%:.")
	if fnm ~= "" then
		st = st .. fnm
	end

	st = st .. "%="

	local di = get_diagnostics()
	if di ~= "" then
		st = st .. di .. " "
	end

	local ft = vim.bo.filetype
	if ft ~= "" then
		st = st .. get_icon() .. ft .. " "
	end

	st = st .. "%l:%c" .. " " .. "%p%%"

	return st
end

vim.o.statusline = '%!v:lua.require("config.statusline").build()'
return M

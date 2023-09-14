vim.o.termguicolor = true
vim.o.background = "dark" -- > or "light" for light mode

-- > import customized themes here
--[[ require("jager.core.colorscheme.onedark") ]]
--[[ require("jager.core.colorscheme.tokyonight") ]]
require("jager.core.colorscheme.catppuccin")

-- CHANGE YOUR THEME HERE
local theme = "catppuccin"

local ok, _ = pcall(vim.cmd, "colorscheme ", theme)
if not ok then
	return
end

vim.cmd("colorscheme " .. theme)

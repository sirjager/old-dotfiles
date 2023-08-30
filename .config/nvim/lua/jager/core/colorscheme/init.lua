vim.o.termguicolor = true
vim.o.background = "dark" -- > or "light" for light mode

-- > import customized themes here
require("jager.core.colorscheme.onedark")
require("jager.core.colorscheme.catppuccin")

-- CHANGE YOUR THEME HERE
local selected_theme = "gruvbox"

local ok, _ = pcall(vim.cmd, "colorscheme ", selected_theme)
if not ok then
	vim.notify({
		"color scheme" .. selected_theme .. " is not available",
	})
	return
end

vim.cmd("colorscheme " .. selected_theme)

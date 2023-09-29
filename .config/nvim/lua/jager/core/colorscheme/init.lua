vim.o.termguicolor = true
vim.o.background = "dark" -- > or "light" for light mode

-- > import customized themes here
--[[ require("jager.core.colorscheme.onedark") ]]
--[[ require("jager.core.colorscheme.tokyonight") ]]
--[[ require("jager.core.colorscheme.catppuccin") ]]

-- CHANGE YOUR THEME HERE
local theme = "gruvbox"

---@diagnostic disable-next-line: param-type-mismatch
local ok, _ = pcall(vim.cmd, "colorscheme ", theme)
if not ok then
  return
end

vim.cmd("colorscheme " .. theme)

-- change colors of line numbers
-- none #A6ADC8 #BAC2DE #585B70 #45475A #B4BEFE #1E1E2E
vim.cmd "hi LineNr guibg=none guifg=#A6ADC8"

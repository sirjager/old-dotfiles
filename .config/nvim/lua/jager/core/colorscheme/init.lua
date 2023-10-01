vim.o.termguicolor = true
vim.o.background = "dark" -- > or "light" for light mode

-- > import customized themes here
--[[ require("jager.core.colorscheme.onedark") ]]
require "jager.core.colorscheme.tokyonight"
--[[ require "jager.core.colorscheme.catppuccin" ]]
--[[ require "jager.core.colorscheme.material" ]]
--[[ require "jager.core.colorscheme.gruvbox" ]]

-- CHANGE YOUR THEME HERE
local theme = "tokyonight"

---@diagnostic disable-next-line: param-type-mismatch
local ok, _ = pcall(vim.cmd, "colorscheme ", theme)
if not ok then
  return
end

vim.cmd("colorscheme " .. theme)

-- change colors of line numbers
-- none #A6ADC8 #BAC2DE #585B70 #45475A #B4BEFE #1E1E2E
-- #B2AC8F #A09A7F #DCD4AF #eeead6 #908B75 #a6a395 #3c3836
vim.cmd "hi LineNr guibg=none guifg=#DCD4AF"

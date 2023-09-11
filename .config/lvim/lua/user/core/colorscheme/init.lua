vim.o.termguicolors = true
vim.o.background = "dark"

--> import customized themes here
-- require("user.core.colorscheme.onedark")
-- require("user.core.colorscheme.catppuccin")

-- change your theme here
local selected_theme = "lunar"

local ok,_ = pcall(vim.cmd, "colorscheme", selected_theme)
if not ok then
  return
end

vim.cmd("colorscheme" .. selected_theme)

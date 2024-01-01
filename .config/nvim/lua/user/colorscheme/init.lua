-- > import customized theme settings here
-- require "user.colorscheme.tokyonight"
-- require "user.colorscheme.gruvbox"
-- require "user.colorscheme.material"
-- require "user.colorscheme.catppuccin"
require "user.colorscheme.onedark"
-- require "user.colorscheme.github-theme"

vim.o.termguicolor = true

vim.o.background = "dark" -- light | dark

-- default theme
vim.cmd "colorscheme onedark"

--[[ -- Line number highlight color ]]
vim.cmd "hi LineNr guibg=none guifg=#8294C4"

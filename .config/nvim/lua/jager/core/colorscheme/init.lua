-- > import customized theme settings here
require "jager.core.colorscheme.tokyonight"
require "jager.core.colorscheme.material"
require "jager.core.colorscheme.catppuccin"
require "jager.core.colorscheme.onedark"
require "jager.core.colorscheme.gruvbox"

vim.o.termguicolor = true

vim.o.background = "dark" -- light | dark

-- default theme
vim.cmd "colorscheme onedark"

--[[ -- Line number highlight color ]]
vim.cmd "hi LineNr guibg=none guifg=#8294C4"

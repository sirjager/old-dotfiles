require "user.colorscheme.onedark"

vim.o.background = "dark" -- light | dark

-- default theme
vim.cmd "colorscheme onedark"

-- Line number highlight color
vim.cmd "hi LineNr guibg=none guifg=#8294C4"

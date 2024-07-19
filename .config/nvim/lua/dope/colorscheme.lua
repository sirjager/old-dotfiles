local M = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
}

M.onedark = {
  -- Default theme style. Choose between 'dark', 'darker',
  -- 'cool', 'deep', 'warm', 'warmer' and 'light'
  style = "cool",
  transparent = true,
  term_colors = true,
  ending_tildes = false,
  cmp_itemkind_reverse = false,
  toggle_style_key = nil,
  code_style = {
    comments = "italic",
    keywords = "bold",
    functions = "italic",
    strings = "none",
    variables = "bold",
  },
  lualine = { transparent = true },
  diagnostics = { darker = true, undercurl = true, background = true },
}

function M.config()
  require("onedark").setup(M.onedark)
  vim.o.background = "dark"
  vim.cmd "colorscheme onedark"
  vim.cmd "hi LineNr guibg=none guifg=#8294C4"
end

return M

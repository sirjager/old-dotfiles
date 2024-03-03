---@diagnostic disable: missing-fields

require("cmp").setup.buffer {
  completion = {
    autocomplete = false,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "codeium" },
    -- { name = "tmux" },
  },
}

-- code folding
local okufo, ufo = pcall(require, "ufo")
if okufo then
  ufo.setup {
    ---@diagnostic disable-next-line: unused-local
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  }
end

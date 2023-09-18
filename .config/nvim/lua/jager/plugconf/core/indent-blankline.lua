local ok, pkg = pcall(require, "indent_blankline")
if not ok then
  return
end

vim.opt.list = true
--[[ vim.opt.listchars:append "space:⋅" ]]
--[[ vim.opt.listchars:append "eol:↴" ]]

pkg.setup {
  show_current_context = true,
  space_char_blankline = " ",
  show_current_context_start = true,
}

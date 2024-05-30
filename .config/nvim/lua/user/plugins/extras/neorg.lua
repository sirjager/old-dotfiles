local neorg_ok, pkg = pcall(require, "neorg")
if not neorg_ok then
  return
end

pkg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.keybinds"] = {},
  },
}

local ok, pkg = pcall(require, "neorg")
if not ok then
  return
end

pkg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.concealer"] = {},
    ["core.keybinds"] = {},

    ["core.dirman"] = {
      config = {
        workspaces = {
          work = "~/Documents/work",
          home = "~/Documents/home",
        },
      },
    },
  },
}

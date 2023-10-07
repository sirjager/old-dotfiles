local ok, pkg = pcall(require, "neorg")
if not ok then
  return
end

pkg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
          home = "~/notes/home",
        },
      },
    },
  },
}

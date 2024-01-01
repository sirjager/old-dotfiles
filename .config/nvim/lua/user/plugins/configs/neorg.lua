local neorg_ok, neorg = pcall(require, "neorg")
if neorg_ok then
  neorg.setup {
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
end

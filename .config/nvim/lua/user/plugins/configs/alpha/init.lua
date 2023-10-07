local ok, alpha = pcall(require, "alpha")
if not ok then
  return
end

--[[ alpha.setup(require("alpha.themes.theta").config) ]]
--
local headers = require "user.plugins.configs.alpha.banners"

local dashboard = require "alpha.themes.dashboard"

-- Set header
dashboard.section.header.val = headers.jagervim

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("<leader>b", "  > Scripts directory", ":cd ~/.local/bin/ | :e ./ <CR> | :NvimTreeOpen<CR> "),
  dashboard.button(
    "<leader>t",
    "  > Tmux configurations",
    ":cd ~/.config/tmux | :NvimTreeOpen<CR> | :e tmux.conf<CR>"
  ),
  dashboard.button(
    "<leader>n",
    "  > Neovim configurations",
    ":cd ~/.config/nvim | :NvimTreeOpen<CR> | :e lua/user/plugins/init.lua<CR>"
  ),
  dashboard.button("<leader>q", "  > Quit NVIM", ":qa<CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

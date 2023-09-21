local ok, pkg = pcall(require, "telescope")
if not ok then
  return
end

pkg.load_extension "project"
pkg.load_extension "media_files"

local actions = require "telescope.actions"
local project_actions = require "telescope._extensions.project.actions"

pkg.setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--no-ignore", -- **This is the added flag**
      "--hidden", -- **Also this flag. The combination of the two is the same as `-uu`**
    },
  },

  file_sorter = require("telescope.sorters").get_fuzzy_file,
  file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/", "^.venv/" },
  generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

  path_display = { "truncate" },
  winblend = 0,
  border = {},

  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  color_devicons = true,

  set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

  pickers = {
    oldfiles = {
      prompt_title = "Recent files",
      prompt_prefix = "   ",
    },
    find_files = {
      prompt_title = "Find files",
      prompt_prefix = "   ",
    },
    live_grep = {
      prompt_title = "Live grep",
      prompt_prefix = "   ",
    },
    help_tags = {
      prompt_title = "Help tags",
      prompt_prefix = " 󰘥  ",
    },
    colorscheme = {
      prompt_title = "Color schemes",
      prompt_prefix = "   ",
    },

    keymaps = {
      prompt_title = "Key bindings",
      prompt_prefix = " 󰌓  ",
    },
  },
  mappings = {
    i = {
      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    },

    n = {
      ["q"] = actions.close,
      ["<esc>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["?"] = actions.which_key,
    },
  },

  extensions_list = { "themes", "media_files", "projects", "terms", "fzf" },

  extensions = {
    projects = {
      base_dirs = {
        { "~/.config/nvim", max_depth = 4 },
        "~/.config/polybar",
        "~/.config/bspwm",
        "~/.config/sxhkd",
      },
      display_type = "full",
      hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      search_by = "title",
      sync_with_nvim_tree = true, -- default false
      -- default for on_project_selected = find project files
      on_project_selected = function(prompt_bufnr)
        -- Do anything you want in here. For example:
        project_actions.change_working_directory(prompt_bufnr, false)
        require("harpoon.ui").nav_file(1)
      end,
    },

    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    media_files = {
      filetypes = {
        "png",
        "webp",
        "jpg",
        "jpeg",
      },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
  },
}

-- INFO: ##################################################
-- Auto installing lazy plugin manager
-- ########################################################
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- TODO: ##################################################
-- These Plugins Will Be Automatically Installed.
-- Install All Your Plugins In This Plugins Table.
-- ########################################################
local plugins = {
  -- TODO: ################################################
  -- Plugins Table Start:
  -- ######################################################

  -- ######################################################
  -- popup menus
  -- ######################################################
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  -- ######################################################
  -- notifications
  -- ######################################################
  "rcarriga/nvim-notify",

  -- ######################################################
  -- icons package
  -- ######################################################
  "nvim-tree/nvim-web-devicons",

  -- ######################################################
  -- sidebar folder explorer, nvim-tree, explorer
  -- ######################################################
  "nvim-tree/nvim-tree.lua",

  -- ######################################################
  -- neoscroll: a smooth scrolling neovim plugin (optional)
  -- ######################################################
  "karb94/neoscroll.nvim",

  -- ######################################################
  -- color schemes (optional)
  -- ######################################################
  "navarasu/onedark.nvim",
  "Mofiqul/dracula.nvim",
  "marko-cerovac/material.nvim",
  { "folke/tokyonight.nvim", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- ######################################################
  -- github related
  -- ######################################################
  "lewis6991/gitsigns.nvim",
  "kdheepak/lazygit.nvim",

  -- ######################################################
  -- color codes hightlighting
  -- ######################################################
  "NvChad/nvim-colorizer.lua",

  -- ######################################################
  -- special comments hightlighting (optional)
  -- TODO:   This is todo comment hightlighting
  -- FIXME: This is fixme comment hightlighting
  -- WARN: This is warning comment hightlighting
  -- PERF: This is performance comment hightlighting
  -- NOTE: This is note comment hightlighting
  -- HACK: This is hack comment hightlighting
  -- INFO: this is info comment hightlighting
  -- ######################################################
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- ######################################################
  -- Keybindings helper/predictionns (optional)
  -- ######################################################
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  -- ######################################################
  -- indentation line hightlighting
  -- ######################################################
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup {}
    end,
  },

  -- ######################################################
  -- tmux navigation, navigates between neovim and tmux (optional)
  -- ######################################################
  { "christoomey/vim-tmux-navigator", lazy = false },

  -- ######################################################
  -- dashboard, start page, first screen after launching (optional)
  -- ######################################################
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  -- ######################################################
  -- bottom bar, alternative: nvim-lualine/lualine.nvim
  -- ######################################################
  "windwp/windline.nvim",
  --[[ "nvim-lualine/lualine.nvim", ]]

  -- ######################################################
  -- neovim tabs
  -- ######################################################
  "akinsho/bufferline.nvim",
  "romgrk/barbar.nvim",

  -- ######################################################
  -- maximizes and restores current window
  -- ######################################################
  { "szw/vim-maximizer", lazy = false },

  -- ######################################################
  -- headings, code folding
  -- ######################################################
  { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

  -- ######################################################
  -- vscode like breadcrumbs (optional)
  -- ######################################################
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = { "SmiteshP/nvim-navic" },
  },

  -- ######################################################
  -- Telescope, quick finder, fuzzy finder
  -- ######################################################
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-project.nvim",
  "nvim-telescope/telescope-media-files.nvim",

  -- ######################################################
  -- shows code context in breadcrumb. (optional)
  -- A simple statusline/winbar component that uses LSP to
  -- show your current code context. Named after the Indian
  -- satellite navigation system.
  -- ######################################################
  "SmiteshP/nvim-navic",

  -- ######################################################
  -- terminal inside neovim (optional)
  -- ######################################################
  "akinsho/toggleterm.nvim",

  -- ######################################################
  -- zen mode, clean ui mode, fullscreen, centered (optional)
  -- ######################################################
  "folke/zen-mode.nvim",

  -- ######################################################
  -- wakatime, time tracker (optional)
  -- ######################################################
  "wakatime/vim-wakatime",

  -- ######################################################
  -- comments support
  -- ######################################################
  "numToStr/Comment.nvim",

  -- ######################################################
  -- json schema support, hinting support in json files (optional)
  -- ######################################################
  "b0o/schemastore.nvim",

  -- ######################################################
  -- markdown file live preview
  -- ######################################################
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "mdx", "markdown.mdx" },
    build = ":call mkdp#util#install()",
  },

  -- ######################################################
  -- rest api client (optional)
  -- ######################################################
  { "rest-nvim/rest.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- ######################################################
  -- database client, sql database client with ui (optional)
  -- ######################################################
  "tpope/vim-dadbod",
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- ######################################################
  -- quick navigate in opened buffers using letters, words (optional)
  -- ######################################################
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,     desc = "Remote Flash" },
      {
        "R",
        mode = { "o", "x" },
        function() require("flash").treesitter_search() end,
        desc = "Treesitter Search"
      },
    },
  },

  -- ######################################################
  -- same word hightlighting under cursor (optional)
  -- ######################################################
  "RRethy/vim-illuminate",

  -- ######################################################
  -- shade, dim inactive buffers, chunk of code (optional)
  -- ######################################################
  "sunjon/shade.nvim",

  -- ######################################################
  -- buffer symbols outline (optional)
  -- ######################################################
  "simrat39/symbols-outline.nvim",

  -- ######################################################
  -- file hopping, quick change maked files (optional)
  -- ######################################################
  "ThePrimeagen/harpoon",

  -- ######################################################
  -- Neorg is an all-encompassing tool based around
  -- structured note taking, project and task management, time
  -- tracking, slideshows, writing typeset documents and much more
  -- ######################################################
  { "nvim-neorg/neorg", build = ":Neorg sync-parsers" },

  -- INFO: ##################################################
  -- lsp (Language server protocols) related plugins
  -- ########################################################

  -- ######################################################
  -- neovim plugin development utils
  -- ######################################################
  { "folke/neodev.nvim", lazy = true },

  -- ######################################################
  -- words surround, auto pairs, auto close tags
  -- ######################################################
  "kylechui/nvim-surround",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

  -- ######################################################
  -- Portable package manager, install and manage various
  -- LSP servers, DAP servers, linters, and formatters.
  -- ######################################################
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "folke/trouble.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim", -- archived
  "jayp0521/mason-null-ls.nvim",

  -- ######################################################
  -- inhanced ui and improved lsp experience
  -- ######################################################
  { "glepnir/lspsaga.nvim", branch = "main", after = "nvim-treesitter" },

  -- ######################################################
  -- code hightlighting, syntax hightlighting
  -- ######################################################
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/playground", -- (optional)

  -- ######################################################
  -- snippet engine, snippet related plugins
  -- ######################################################
  "L3MON4D3/LuaSnip",
  "onsails/lspkind-nvim",
  "rafamadriz/friendly-snippets",

  -- ######################################################
  -- code action , quick fix menu
  -- ######################################################
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

  -- ######################################################
  -- code completion, completion menu
  -- ######################################################
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-path", -- filesystem paths completions
  "hrsh7th/cmp-buffer", -- completions from opened buffers
  "hrsh7th/cmp-cmdline", -- completions in commandline mode
  "hrsh7th/cmp-nvim-lsp", -- completions from lsp
  "saadparwaiz1/cmp_luasnip",
  "andersevenrud/cmp-tmux", -- completions of tmux sessions (optional)
  "hrsh7th/cmp-emoji", -- emoji completions (optional)
  "hrsh7th/cmp-calc", -- inline calc completions (optional)

  -- ######################################################
  -- code debuging. may need to install 'lldb' from your system pkg manager
  -- ######################################################
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },

  -- ######################################################
  -- python code debugger
  -- ######################################################
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function(_, _)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },

  -- ######################################################
  -- prisma file support: schema.prisma etc (optional)
  -- ######################################################
  "prisma/vim-prisma",

  -- ######################################################
  -- rust lsp, rust language support,
  -- ######################################################
  { "simrat39/rust-tools.nvim", ft = "rust" },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- ######################################################
  -- rust crates support, cartes file support. (optional)
  -- ######################################################
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    event = { "BufRead Cargo.toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  -- ######################################################
  -- go golang language support
  -- ######################################################
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function()
      require("gopher").setup {}
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },

  -- ######################################################
  -- typescript language support
  -- ######################################################
  "jose-elias-alvarez/typescript.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- ######################################################
  -- flutter / dart language support
  -- ######################################################
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    config = true,
  },

  -- TODO: ################################################
  -- Plugins Table End
  -- ######################################################
}

-- INFO: ##################################################
-- Initializing lazy and auto installing all plugins
-- ########################################################
require("lazy").setup(plugins, {})

-- INFO: ##################################################
-- Initializing notify plugins
-- ########################################################
local ok, notify = pcall(require, "notify")
if ok then
  vim.opt.termguicolors = true
  notify.setup {
    background_colour = "#000000",
    fps = 60,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = "",
    },
    level = 2,
    minimum_width = 50,
    render = "compact", -- default, minimal, simple, compact
    stages = "fade_in_slide_out", -- fade_in_slide_out, fade, slide, static
    timeout = 2500,
    top_down = true,
  }
  vim.notify = notify
end

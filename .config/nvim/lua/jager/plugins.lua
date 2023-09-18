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

local plugins = {
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "rcarriga/nvim-notify",

  -- tools/utils
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "linrongbin16/lsp-progress.nvim",
    },
  },
  {
    "linrongbin16/lsp-progress.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lsp-progress").setup()
    end,
  },

  -- windows navigation works well with tmux
  { "christoomey/vim-tmux-navigator", lazy = false },
  { "szw/vim-maximizer", lazy = false }, -- maximizes and restores current window

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- ui
  "romgrk/barbar.nvim",
  "karb94/neoscroll.nvim",
  "sunjon/shade.nvim",
  "nvim-tree/nvim-tree.lua",
  "akinsho/bufferline.nvim",
  "windwp/windline.nvim",
  "nvim-tree/nvim-web-devicons",
  "RRethy/vim-illuminate",
  "simrat39/symbols-outline.nvim",
  "SmiteshP/nvim-navic",
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },

  -- colorschemes
  "navarasu/onedark.nvim",
  "morhetz/gruvbox",
  "Mofiqul/dracula.nvim",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "AlphaTechnolog/pywal.nvim", as = "pywal" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- github
  "lewis6991/gitsigns.nvim",
  "kdheepak/lazygit.nvim",

  "ThePrimeagen/harpoon",

  -- telescope
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-project.nvim",
  "nvim-telescope/telescope-media-files.nvim",

  -- colors hightlight
  --[[ "norcalli/nvim-colorizer.lua", ]]
  "NvChad/nvim-colorizer.lua",

  -- snippet engine
  "L3MON4D3/LuaSnip",
  "onsails/lspkind-nvim", -- vscode like icons for autocompletion popup menu
  "rafamadriz/friendly-snippets",

  -- code action menu
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },

  -- code debuging: sudo pacman -Syu lldb
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, _)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },

  -- lsp
  "folke/trouble.nvim",
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "jayp0521/mason-null-ls.nvim",

  -- inhanced ui and improved lsp experience
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    after = "nvim-treesitter",
  },
  {
    "folke/neodev.nvim",
    lazy = true,
  },

  -- rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },

  -- go auto structs and more
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

  -- treesitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",

  "lukas-reineke/indent-blankline.nvim",

  -- ######################################################
  -- Completions
  -- ######################################################
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-path", -- filesystem paths completions
  "hrsh7th/cmp-buffer", -- completions from opened buffers
  "hrsh7th/cmp-cmdline", -- completions in commandline mode
  "hrsh7th/cmp-nvim-lsp", -- completions from lsp
  "saadparwaiz1/cmp_luasnip",
  "andersevenrud/cmp-tmux", -- completions of tmux sessions
  "hrsh7th/cmp-emoji", -- emoji completions
  "hrsh7th/cmp-calc", -- inline calc completions
  {
    "tzachar/cmp-tabnine", -- tabnine completions
    build = "./install.sh",
    dependencies = "hrsh7th/nvim-cmp",
  },

  -- comments
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- terminal
  "akinsho/toggleterm.nvim",

  -- rest client
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

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
        desc =
        "Treesitter Search"
      },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  },

  -- wakatime
  --[[ "wakatime/vim-wakatime", ]]

  -- language specific
  "jose-elias-alvarez/typescript.nvim", -- for advance typescript features

  -- words surround, autopairs
  "kylechui/nvim-surround",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
}

local opts = {}

require("lazy").setup(plugins, opts)

-- needed by notify to work properly and avoid warnings
vim.opt.termguicolors = true

-- Notification
local ok, notify = pcall(require, "notify")
if not ok then
  return
end

---@diagnostic disable-next-line: missing-fields
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

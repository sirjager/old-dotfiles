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
  {
    "rcarriga/nvim-notify",
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      local ok, notify = pcall(require, "notify")
      if not ok then
        return
      end
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
        render = "compact",           -- default, minimal, simple, compact
        stages = "fade_in_slide_out", -- fade_in_slide_out, fade, slide, static
        timeout = 2500,
        top_down = true,
      }
      vim.notify = notify
    end
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.o.background = "dark" -- light | dark
      vim.cmd "colorscheme onedark"
      vim.cmd "hi LineNr guibg=none guifg=#8294C4"
    end
  },
  -- "Mofiqul/dracula.nvim",
  -- { "projekt0n/github-nvim-theme" },
  -- "marko-cerovac/material.nvim",
  -- { "folke/tokyonight.nvim", priority = 1000 },
  -- { "ellisonleao/gruvbox.nvim", priority = 1000 },
  -- { "catppuccin/nvim",       name = "catppuccin", priority = 1000 },


  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },



  "nvim-tree/nvim-web-devicons",
  -- {"nvim-tree/nvim-tree.lua"},
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
      "3rd/image.nvim",
    },
  },


  "Exafunction/codeium.vim",
  "lewis6991/gitsigns.nvim",
  "kdheepak/lazygit.nvim",



  'Equilibris/nx.nvim',

  {
    "epwalsh/obsidian.nvim",
    ft = { "markdown" },
    version = "*",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    lazy = true
  },


  "karb94/neoscroll.nvim",
  "ziontee113/color-picker.nvim",
  "NvChad/nvim-colorizer.lua",
  "aurum77/live-server.nvim",


  -- indentation line hightlighting
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function()
      require("hlchunk").setup {}
    end,
  },


  -- tmux navigation, navigates between neovim and tmux (optional)
  { "christoomey/vim-tmux-navigator", lazy = false },


  -- dashboard, start page, first screen after launching (optional)
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },


  -- bottom bar, alternative: nvim-lualine/lualine.nvim
  "windwp/windline.nvim",
  -- "nvim-lualine/lualine.nvim",


  -- neovim tabs
  "akinsho/bufferline.nvim",
  -- "romgrk/barbar.nvim",


  -- maximizes and restores current window
  { "szw/vim-maximizer",              lazy = false },


  -- headings, code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "luukvbaal/statuscol.nvim",
    },
  },

  -- logs in buffers
  {
    "0x100101/lab.nvim",
    build = "cd js && npm ci"
  },

  {
    'paopaol/telescope-git-diffs.nvim',
    dependencies = {
      "sindrets/diffview.nvim",
    },
  },

  -- Telescope, quick finder, fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },


  -- shows code context in breadcrumb. (optional)
  -- "SmiteshP/nvim-navic",


  -- terminal inside neovim (optional)
  -- "akinsho/toggleterm.nvim",


  -- zen mode, clean ui mode, fullscreen, centered (optional)
  "folke/zen-mode.nvim",
  "folke/twilight.nvim",


  -- wakatime, time tracker (optional)
  "wakatime/vim-wakatime",


  -- comments support
  {
    "numToStr/Comment.nvim",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "VeryLazy",
      }
    }
  },


  -- json schema support, hinting support in json files (optional)
  "b0o/schemastore.nvim",


  -- -- markdown file live preview
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },


  -- -- rest api client (optional), required dependencies : lua-curl, xml2lua
  -- { "rest-nvim/rest.nvim", dependencies = { "nvim-lua/plenary.nvim" } },


  -- database client, sql database client with ui (optional)
  "tpope/vim-dadbod",
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },


  -- quick navigate in opened buffers using letters, words (optional)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- stylua: ignore
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" } },
  },


  -- same word hightlighting under cursor (optional)
  "RRethy/vim-illuminate",


  -- -- shade, dim inactive buffers, chunk of code (optional)
  -- "sunjon/shade.nvim",


  -- buffer symbols outline (optional)
  -- "simrat39/symbols-outline.nvim",

  -- file hopping, quick change maked files (optional)
  { "ThePrimeagen/harpoon",     branch = "harpoon2",                       requires = { { "nvim-lua/plenary.nvim" } } },

  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1000,
  --   -- opts = { rocks = { "fzy", "pathlib.nvim ~> 1.0" } },
  -- },
  -- { "nvim-neorg/neorg",  version = "*" },

  "roobert/tailwindcss-colorizer-cmp.nvim",
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- lsp (Language server protocols) related plugins
  { "folke/neodev.nvim",        lazy = true },

  -- words surround, auto pairs, auto close tags
  "kylechui/nvim-surround",
  "windwp/nvim-autopairs",
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "markdown", "typescript", "javascriptreact", "typescriptreact" }
  },


  -- code linting, linter
  { "mfussenegger/nvim-lint", event = { "BufReadPre", "BufNewFile" } },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "jayp0521/mason-null-ls.nvim",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim", -- new fork of null-ls (alternative of null-ls),
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-shellcheck.nvim",
    },
  },

  "jose-elias-alvarez/typescript.nvim",
  { "Fymyte/rasi.vim",        ft = { "rasi" } },



  -- inhanced ui and improved lsp experience
  { "glepnir/lspsaga.nvim",   branch = "main",                       after = "nvim-treesitter" },
  "folke/trouble.nvim",

  -- code hightlighting, syntax hightlighting
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  -- "nvim-treesitter/playground", -- (optional)

  -- snippet engine, snippet related plugins
  "L3MON4D3/LuaSnip",
  "onsails/lspkind-nvim",
  "rafamadriz/friendly-snippets",

  -- code action , quick fix menu
  { "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" },

  -- code completion, completion menu
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",          -- filesystem paths completions
      "FelipeLema/cmp-async-path", -- same as path with async
      "hrsh7th/cmp-buffer",        -- completions from opened buffers
      "hrsh7th/cmp-cmdline",       -- completions in commandline mode
      "hrsh7th/cmp-nvim-lsp",      -- completions from lsp
      "hrsh7th/cmp-nvim-lua",      -- completions for lua
      "saadparwaiz1/cmp_luasnip",
      "andersevenrud/cmp-tmux",    -- completions of tmux sessions (optional)
      "hrsh7th/cmp-emoji",         -- emoji completions (optional)
      -- "hrsh7th/cmp-calc",          -- inline calc completions (optional)
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ"
    },
  },


  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
  },

  -- golang A modern go neovim plugin based on treesitter, nvim-lsp and dap debugger ]]
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

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
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- A framework for interacting with tests within NeoVim.
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- go test package
      "nvim-neotest/neotest-go",
    }
  },

  -- python code debugger

  -- {
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
  --   config = function(_, _)
  --     local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  --     require("dap-python").setup(path)
  --   end,
  -- },


  -- "prisma/vim-prisma",


  -- -- rust lsp, rust language support,
  -- { "simrat39/rust-tools.nvim", ft = "rust" },
  -- {
  --   "rust-lang/rust.vim",
  --   ft = "rust",
  --   init = function()
  --     vim.g.rustfmt_autosave = 1
  --   end,
  -- },

  -- -- rust crates support, cartes file support. (optional)
  -- {
  --   "saecki/crates.nvim",
  --   ft = { "rust", "toml" },
  --   event = { "BufRead Cargo.toml" },
  --   config = function(_, opts)
  --     local crates = require "crates"
  --     crates.setup(opts)
  --     crates.show()
  --   end,
  -- },

  -- flutter / dart language support
  -- {
  --   "akinsho/flutter-tools.nvim",
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "Neevash/awesome-flutter-snippets",
  --   },
  --   config = true,
  -- },

}

-- INFO: ##################################################
-- Initializing lazy and auto installing all plugins
require("lazy").setup(plugins, {})

lvim.plugins = {
  -- notification 
	"rcarriga/nvim-notify",

  -- windows navigation between tmux panes and neovim
	{ "christoomey/vim-tmux-navigator", lazy = false },

  -- maximizes and restores current window
	{ "szw/vim-maximizer", lazy = false },

  -- tabs 
	"romgrk/barbar.nvim",

  -- smooth scroll
	"karb94/neoscroll.nvim",

	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-media-files.nvim",

  -- colorizer
	"norcalli/nvim-colorizer.lua",

  -- github
	"kdheepak/lazygit.nvim",

  -- hop around file using kewords 
  {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = function()
        require('hop').setup()
      end
  },

	-- colorschemes / themes
	"navarasu/onedark.nvim",
	"morhetz/gruvbox",
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "AlphaTechnolog/pywal.nvim", name = "pywal" },

  -- Todo colorized comments
  {
      "folke/todo-comments.nvim",
      event = "BufRead",
      config = function()
        require("todo-comments").setup()
      end
    },

  -- reopen all last opened files / restore session
  {
      "folke/persistence.nvim",
      event = "BufReadPre",
      config = function()
        require("persistence").setup({
          dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
          options = { "buffers", "curdir", "tabpages", "winsize" }
        })
      end
    },

  -- go auto structs and more
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_)
			require("gopher").setup()
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},

  -- typescript
  { 'jose-elias-alvarez/typescript.nvim' },
  {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    },
}

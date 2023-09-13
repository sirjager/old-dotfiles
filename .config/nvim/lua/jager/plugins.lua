local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
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

	-- windows navigation works well with tmux
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "szw/vim-maximizer", lazy = false }, -- maximizes and restores current window

	-- ui
	"romgrk/barbar.nvim",
	"karb94/neoscroll.nvim",
	"sunjon/shade.nvim",
	"nvim-tree/nvim-tree.lua",
	"akinsho/bufferline.nvim",
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-web-devicons",

	-- colorschemes
	"navarasu/onedark.nvim",
	"morhetz/gruvbox",
	"Mofiqul/dracula.nvim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "AlphaTechnolog/pywal.nvim", as = "pywal" },

	-- github
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",

	-- telescope
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-media-files.nvim",

	-- words surround, autopairs
	"kylechui/nvim-surround",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",

	-- colors hightlight
	"norcalli/nvim-colorizer.lua",

	-- snippet engine
	"L3MON4D3/LuaSnip",
	"onsails/lspkind-nvim", -- vscode like icons for autocompletion popup menu
	"rafamadriz/friendly-snippets",

	-- code debuging: sudo pacman -Syu lldb
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",

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

	-- language specific
	"jose-elias-alvarez/typescript.nvim", -- for advance typescript features

	-- rust
	"simrat39/rust-tools.nvim",
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},

	-- go auto structs and more
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function()
			require("gopher").setup()
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},

	-- treesitter
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",

	"lukas-reineke/indent-blankline.nvim",
	"HiPhish/nvim-ts-rainbow2",

	-- completions
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"saadparwaiz1/cmp_luasnip",

	-- linter
	"mfussenegger/nvim-lint",

	-- comments
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- terminal
	"akinsho/toggleterm.nvim",

	-- wakatime
	--[[ "wakatime/vim-wakatime", ]]
}

local opts = {}

require("lazy").setup(plugins, opts)

-- needed by notify to work properly and avoid warnings
vim.opt.termguicolors = true

-- Notification
local packagename = "notify"
local ok, notify = pcall(require, packagename)
if not ok then
	return
end

notify.setup({
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
})

vim.notify = notify

local pkgname = "nvim-tree"
local ok, pkg = pcall(require, pkgname)
if not ok then
	vim.notify({
		packagename .. " is not installed",
		"warn",
	})
	return
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- local opts  = { noremap = true, silent = true }
-- vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>', opts)

pkg.setup({
	sort_by = "case_sensitive",

	view = {
		width = 35,
		side = "left",
		signcolumn = "yes",

		number = true,
		cursorline = true,
		relativenumber = true,

		debounce_delay = 15,
		hide_root_folder = false,
		centralize_selection = true,
		preserve_window_proportions = true,

		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},

	renderer = {
		add_trailing = false,
		highlight_git = true,
		group_empty = false, -- shows in one line is single child
		indent_width = 2,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			modified_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				git = true,
				file = true,
				folder = true,
				modified = true,
				folder_arrow = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "",
				modified = "●",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		special_files = {
			"Cargo.toml",
			"Makefile",
			"README.org",
			"README.md",
			"readme.md",
		},
		symlink_destination = true,
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	filters = {
		dotfiles = false,
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
	},
})

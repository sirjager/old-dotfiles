local ok, pkg = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

pkg.setup({
	ensure_installed = {
		"bash",
		"go",
		"html",
		"http",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"vim",
		"yaml",
	},

	-- Install parsers syncronously (only applicable to `ensure_installed`)
	sync_install = false,
	auto_install = true,

	indent = { enable = true },

	highlights = {
		enable = true,
		use_languagetree = true,
	},

	refactor = {
		highlight_current_scope = {
			enable = true,
		},

		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
		},

		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},

		navigation = {
			enable = true,
			-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				list_definitions_toc = "gO",
				goto_next_usage = "<A->",
				goto_previous_usage = "<A-<",
			},
		},

		indent = {
			enable = true,
			disable = {
				"yaml",
			},
		},

		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
	},

	autotag = {
		enable = true,
	},

	rainbow = {
		enable = true,
		disable = { "cpp" },
		query = "rainbow-parens",
		strategy = require("ts-rainbow").strategy.global,
	},
})

local packagename = "nvim-treesitter.configs"
local ok, treesitter = pcall(require, packagename)
if not ok then
	vim.notify({ packagename .. " is not installed" }, "warn")
	return
end

treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"bash",
		"css",
		"dockerfile",
		"gitignore",
		"go",
		"gomod",
		"html",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"proto",
		"python",
		"sql",
		"yaml",
	},

	-- Install parsers syncronously (only applicable to `ensure_installed`)
	sync_install = true,
	auto_install = false,

	highlights = {
		enable = true,
		use_languagetree = true,
	},

	refactor = {
		highlight_current_scope = {
			enable = false,
		},

		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
		},

		smart_rename = {
			enable = true,
			-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
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
		-- list of languages you want to disable the plugin for
		disable = { "cpp" },
		-- Which query to use for finding delimiters
		query = "rainbow-parens",
		-- Highlight the entire buffer all at once
		strategy = require("ts-rainbow").strategy.global,
	},
})

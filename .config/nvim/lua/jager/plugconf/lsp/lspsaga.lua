local ok, lspsaga = pcall(require, "lspsaga")
if not ok then
	return
end

lspsaga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
	-- use enter to open file with definition preview
	definition = {
		edit = "<CR>",
	},
	code_action = {
		num_shortcut = true,
		show_server_name = true, -- default false
		extend_gitsigns = true, -- default false
	},
	ui = {
		title = true,
		devicons = true,
		border = "single",

		code_action = "💡",

		lines = { "┗", "┣", "┃", "━", "┏" },

		colors = {
			normal_bg = "#022746",
		},
	},
})

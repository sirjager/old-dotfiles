local ok, pkg = pcall(require, "dashboard")
if not ok then
	return
end

pkg.setup({
	theme = "hyper", --  theme is doom and hyper default is hyper
	disable_move = false, --  default is false disable move keymap for hyper
	shortcut_type = "number", --  shorcut type 'letter' or 'number'
	change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
	hide = {
		statusline = true, -- hide statusline default is true
		tabline = false, -- hide the tabline
		winbar = false, -- hide winbar
	},
	config = {
		week_header = {
			enable = false,
		},
		packages = { enable = true },
		project = { enable = true, limit = 4, icon = "  ", label = "Projects", action = "Telescope find_files cwd=" },
		mru = { limit = 6, icon = "  ", label = "Recent Files" },
	},
})

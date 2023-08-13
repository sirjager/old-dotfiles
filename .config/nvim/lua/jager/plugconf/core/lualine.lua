local packagename = "lualine"

local ok, lualine = pcall(require, packagename)
if not ok then
	vim.notify({
		packagename .. " is not installed",
		"warn",
	})
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",

		component_separators = {
			left = "",
			right = "",
		},

		section_seperatiors = {
			left = "",
			right = "",
		},
	},

	sections = {
		lualine_a = {
			{
				"filename",
				-- path = 1
			},
		},
	},
})

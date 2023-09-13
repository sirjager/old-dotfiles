local ok, lualine = pcall(require, "lualine")
if not ok then
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

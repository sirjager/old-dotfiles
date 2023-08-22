local pkg1 = "nvim-autopairs"
local ok, autopairs = pcall(require, pkg1)
if not ok then
	vim.notify({ pkg1 .. " is not installed" }, "warn")
	return
end

autopairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local pkg2 = "cmp"
local ok, cmp = pcall(require, pkg2)
if not ok then
	vim.notify({ pkg2 .. " is not installed" }, "warn")
	return
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		map_char = {
			tex = "",
		},
	})
)

local ok1, autopairs = pcall(require, "nvim-autopairs")
if not ok1 then
	return
end

autopairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string", "source" },
		javascript = { "string", "template_string" },
		java = false,
	},
	disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },
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

local ok2, cmp = pcall(require, "cmp")
if not ok2 then
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

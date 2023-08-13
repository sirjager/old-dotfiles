local pkgname = "indent_blankline"
local ok, pkg = pcall(require, pkgname)
if not ok then
	vim.notify({
		pkgname .. " is not installed",
		"warn",
	})
	return
end

vim.opt.list = true
--[[ vim.opt.listchars:append("eol:↴") ]]

pkg.setup({
	show_current_context = true,
	space_char_blankline = " ",
	show_current_context_start = true,
})

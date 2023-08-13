local pkgname = "nvim-surround"
local ok, pkg = pcall(require, pkgname)
if not ok then
	vim.notify({
		packagename .. " is not installed",
		"warn",
	})
	return
end

pkg.setup()

-- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt

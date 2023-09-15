local ok, pkg = pcall(require, "harpoon")
if not ok then
	return
end

pkg.setup({})

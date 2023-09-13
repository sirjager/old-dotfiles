local ok, pkg = pcall(require, "colorizer")
if not ok then
	return
end

pkg.setup({ "*" })

local name = "colorizer"
local ok, pkg = pcall(require, name)
if not ok then
	vim.notify({ pkg .. " is not installed" }, "warn")
	return
end

pkg.setup({ "*" })

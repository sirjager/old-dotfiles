local pkg = "colorizer"
local ok, autopairs = pcall(require, pkg1)
if not ok then
	vim.notify({ pkg .. " is not installed" }, "warn")
	return
end

pkg.setup({
	"*",
})

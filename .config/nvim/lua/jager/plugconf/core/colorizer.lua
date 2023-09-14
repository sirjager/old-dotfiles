local ok, pkg = pcall(require, "colorizer")
if not ok then
	return
end

pkg.setup({
	"*", -- Highlight all files, but customize some others.
	"!vim", -- Exclude vim from highlighting.
})

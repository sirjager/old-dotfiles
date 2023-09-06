local pkgname = "lint"
local ok, lint = pcall(require, pkgname)
if not ok then
	vim.notify({ pkgname .. " is not installed", "warn" })
	return
end

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
}

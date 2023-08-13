local pkgname = "mason"
local ok, mason = pcall(require, pkgname)
if not ok then
	vim.notify({
		pkgname .. " is not installed",
		"warn",
	})
	return
end

mason.setup()

pkgname = "mason-lspconfig"
local ok, mason_lspconfig = pcall(require, pkgname)
if not ok then
	vim.notify({
		pkgname .. " is not installed",
		"warn",
	})
	return
end

local servers = {
	"cssls",
	"emmet_ls",
	"gopls",
	"lua_ls",
	"html",
	"bufls",
	"marksman",
}

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true, -- not the same as ensure_installed
})

local pkgname = "mason-null-ls"
local ok, mason_null_ls = pcall(require, pkgname)
if not ok then
	vim.notify({ pkgname .. " is not installed", "warn" })
	return
end

local linters_formatters = {
	"gofumpt",
	"goimports_reviser",
	"golines",
	"bufls",
	"stylua",
	"markdownlint",
}

mason_null_ls.setup({
	ensure_installed = linters_formatters,
	automatic_installation = true, -- not the same as ensure_installed
})

local ok1, mason = pcall(require, "mason")
if not ok1 then
	return
end

local ok2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok2 then
	return
end

local ok3, mason_null_ls = pcall(require, "mason-null-ls")
if not ok3 then
	return
end

mason.setup({
	PATH = "prepend",
	max_concurrent_installers = 10,
	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
})

mason_lspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		"gopls",
		"lua_ls",
		"html",
		"marksman",
	},
})

mason_null_ls.setup({
	automatic_installation = true,
	ensure_installed = {
		"codelldb", -- rust, c,cpp debugger
		"eslint-lsp",
		"gofumpt",
		"goimports_reviser",
		"golines",
		"lua-language-server",
		"markdownlint",
		"rust-analyzer",
		"stylua",
		"typescript-languange-server",
	},
})

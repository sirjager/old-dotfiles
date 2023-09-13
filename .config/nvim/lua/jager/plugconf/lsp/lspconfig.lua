local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	return
end

local ok2, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok2 then
	return
end

-- enable keybinds for available lsp servers
local on_attach = function(_, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- example mappings. (my mappings are key in keymaps.lua)
	--[[ local opts = { noremap = true, silent = true, buffer = bufnr } ]]
	--[[ vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor ]]
end

-- enable autocompletion capabilities

local capabilities = cmp_nvim_lsp.default_capabilities()

local util = require("lspconfig/util")

-- configure gopls server
lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", "go.sum", ".git"),
	settings = {
		gopls = {
			analyses = {
				assign = true,
				atomic = true,
				bools = true,
				composites = true,
				copylocks = true,
				deepequalerrors = true,
				embed = true,
				errorsas = true,
				fieldalignment = true,
				httpresponse = true,
				ifaceassert = true,
				loopclosure = true,
				lostcancel = true,
				nilfunc = true,
				nilness = true,
				nonewvars = true,
				printf = true,
				shadow = true,
				shift = true,
				simplifycompositelit = true,
				simplifyrange = true,
				simplifyslice = true,
				sortslice = true,
				stdmethods = true,
				stringintconv = true,
				structtag = true,
				testinggoroutine = true,
				tests = true,
				timeformat = true,
				unmarshal = true,
				unreachable = true,
				unsafeptr = true,
				unusedparams = true,
				unusedresult = true,
				unusedvariable = true,
				unusedwrite = true,
				useany = true,
			},
			hoverKind = "FullDocumentation",
			linkTarget = "pkg.go.dev",
			usePlaceholders = true,
			vulncheck = "Imports",
		},
	},
})

-- configure lua server (with special settings)
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		perferences = {
			disableSuggestions = true,
		},
	},
})

local ok3, rust_tools = pcall(require, "rust-tools")
if not ok3 then
	return
end

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = function(_, bufnr)
		vim.keymap.set("n", "<leader>lh", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
		vim.keymap.set("n", "<leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
	end,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})

local mason_registry = require("mason-registry")
local lldb = mason_registry.get_package("codelldb")
local lldb_ext_path = lldb:get_install_path() .. "/extension/"
local lldbpath = lldb_ext_path .. "adapter/codelldb"
local liblldb_path = lldb_ext_path .. "lldb/lib/liblldb.dylib"

rust_tools.setup({
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(lldbpath, liblldb_path),
	},

	server = {
		capabilities = capabilities,
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<leader>lh", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
			vim.keymap.set("n", "<leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},

	tools = {
		hover_actions = {
			auto_focus = true,
		},
	},
})

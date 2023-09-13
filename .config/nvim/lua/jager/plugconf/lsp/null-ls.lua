local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format = null_ls.builtins.formatting

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		format.gofumpt,
		format.goimports_reviser,
		format.golines,
		format.stylua, -- lua formatter
		--[[ diagnostics.buf, -- proto ]]
		--[[ format.buf, ]]
	},

	-- configure format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
					local lintok, lint = pcall(require, "lint")
					if lintok then
						lint.try_lint()
					end
				end,
			})
		end
	end,
})

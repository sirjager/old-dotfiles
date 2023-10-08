local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--[[ local format = null_ls.builtins.formatting ]]
local diagnostic = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

-- configure null_ls
null_ls.setup {
  -- setup formatters & linters
  sources = {
    --[[ format.shfmt, ]]
    actions.shellcheck,
    --[[ format.stylua, ]]
    --[[ format.rustywind, ]]
    --[[ format.gofumpt, ]]
    --[[ format.golines, ]]
    --[[ format.goimports_reviser, ]]
    --[[ format.black, ]]
    diagnostic.ruff,
    actions.eslint_d,
    diagnostic.eslint_d.with {
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    },
    --[[ format.prettierd, ]]
  },

  -- configure format on save
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      --
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })

      --
    end
  end,
}

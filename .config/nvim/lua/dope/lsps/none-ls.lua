local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-shellcheck.nvim",
  }
}

function M.config()
  local null_ls = require("null-ls")

  local formatting = null_ls.builtins.formatting;
  local diagnostics = null_ls.builtins.diagnostics;
  -- local completion = null_ls.builtins.completion;
  local code_actions = null_ls.code_actions;

  null_ls.setup {
    debug = true,
    sources = {
      formatting.stylua,
      formatting.shfmt,
      formatting.buf,
      formatting.yamlfix,

      -- completion.spell,

      -- diagnostics.eslint_d,
      formatting.prettierd,
      -- formatting.eslint_d,
      -- code_actions.eslint_d,

      formatting.gofumpt,           -- go
      diagnostics.golangci_lint,    -- go
      formatting.goimports_reviser, -- go imports
      formatting.golines,           -- go

    }
  }
end

return M;

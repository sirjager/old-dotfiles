local ok, pkg = pcall(require, "conform")
if not ok then
  return
end

pkg.setup {
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 5000,
  },

  --[[ format_after_save = { ]]
  --[[   lsp_fallback = true, ]]
  --[[   async = false, ]]
  --[[   timeout_ms = 5000, ]]
  --[[ }, ]]

  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  formatters_by_ft = {
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "eslint_d", "prettierd" },

    javascriptreact = { "eslint_d", "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    typescriptreact = { "eslint_d", "prettierd" },
    markdown = { { "markdownlint", "prettierd" } },
    mdx = { { "markdownlint", "prettierd" } },
    python = { "isort", "black" },
    rust = { "rustywind" },
    sh = { "shfmt" },
    lua = { "stylua" },
    json = { { "jq", "prettierd" } },
    dart = { "dart_format" },
    go = { "gofumpt", "golines", "goimports" },
    yaml = { "yamlfix", "yamlfmt" },
    ["_"] = { "trim_whitespace" },
  },
}

--[[ vim.keymap.set({ "n", "v" }, "<leader>mp", function() ]]
--[[   pkg.format { ]]
--[[     lsp_fallback = true, ]]
--[[     async = false, ]]
--[[     timeout_ms = 5000, ]]
--[[   } ]]
--[[ end, { desc = "Format file without saving" }) ]]

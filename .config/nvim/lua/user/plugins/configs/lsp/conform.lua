local ok, pkg = pcall(require, "conform")
if not ok then
  return
end

pkg.setup {
  format_on_save = {
    lsp_fallback = true,
    async = true,
    timeout_ms = 5000,
  },

  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    markdown = { { "markdownlint" } },
    mdx = { { "markdownlint" } },
    org = { { "markdownlint", "prettier" } },
    norg = { { "markdownlint", "prettier" } },
    python = { "isort", "black" },
    php = { "phpcbf", "php_cs_fixer" },
    rust = { "rustywind" },
    sh = { { "shfmt", "beautysh" } },
    sql = { { "sql_formatter" } },
    lua = { "stylua" },
    json = { { "jq", "prettier" } },
    dart = { "dart_format" },
    --[[ go = { "gofumpt", "golines", "goimports" }, -- using null-ls ]]
    yaml = { "yamlfix", "yamlfmt" },
    makefile = { "prettier" },
    -- ["_"] = { "trim_whitespace" },
  },
}

--[[ vim.keymap.set({ "n", "v" }, "<leader>mp", function() ]]
--[[   pkg.format { ]]
--[[     lsp_fallback = true, ]]
--[[     async = false, ]]
--[[     timeout_ms = 5000, ]]
--[[   } ]]
--[[ end, { desc = "Format file without saving" }) ]]

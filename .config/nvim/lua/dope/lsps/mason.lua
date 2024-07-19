local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "jayp0521/mason-null-ls.nvim",
    "nvim-lua/plenary.nvim",
  },
}

M.servers = {
  "lua_ls",
  "bashls",
  "clangd",
  "cssls",
  -- "prismals",
  -- "eslint", -- ts,js
  "emmet_ls",
  "gopls", -- go
  "golangci_lint_ls",
  "html", -- html
  "jsonls", -- json
  -- "marksman", -- md
  "tsserver", -- ts
  "tailwindcss",
  "cssmodules_ls",
  -- "pylsp",
  -- "pyright", -- py
  "yamlls", -- yml
  -- "sqlls",
}

M.null_ls_servers = {
  -- @astrojs/language-server@2.6.3 -- working -- latest is broken
  "astro-language-server", -- astro
  -- "black", -- py
  -- "codelldb", -- rust, c,cpp debugger
  -- "debugpy", -- py
  -- "beautysh",
  "buf",
  -- "terraform-ls",
  "buf-language-server",
  -- "eslint", -- ts,js
  "eslint_d", -- ts,js
  "gofumpt", -- go
  -- "mypy", -- py
  "codespell",
  -- "yamllint", -- yml
  -- "ruff", -- py
  -- "rustywind",
  -- "shellharden", -- sh
  "shellcheck",
  "jq",
  -- "shfmt",
  -- "sqlfmt",
  -- "sql-formatter",
  "fixjson",
  "golangci-lint",
  "gospel",
  "gofumpt",
  "goimports_reviser", -- go
  -- "golines",                         -- go
  "lua-language-server", -- lua
  -- "svelte-language-server",          -- lua
  "docker-compose-language-service", -- docker-compose.yaml
  "dockerfile-language-server", -- Dockerfile
  -- "markdownlint",                    -- md
  -- "mdx_analyzer",
  "prettierd", -- ts, js
  -- "rust-analyzer", -- rust
  "stylua", -- lua
  "typescript-languange-server", -- ts,js
  "protolint",
  -- "yamlfix",                     -- yml
  -- "phpcs",
  -- "php-cbf",
  -- "php-cs-fixer",
}

function M.config()
  require("mason").setup {
    ui = {
      border = "rounded",
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌 ",
      },
    },
  }
  require("mason-lspconfig").setup {
    automatic_installation = false,
    ensure_installed = M.servers,
  }

  require("mason-null-ls").setup {
    automatic_installation = false,
    ensure_installed = M.null_ls_servers,
  }
end

return M

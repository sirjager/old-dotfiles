local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local ok2, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok2 then
  return
end

-- code folding
local ok3, ufo = pcall(require, "ufo")
if ok3 then
  ufo.setup {
    ---@diagnostic disable-next-line: unused-local
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  }
end

local util = require "lspconfig/util"

-- enable autocompletion capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- ufo: code folding
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- enable keybinds for available lsp servers
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- jsonls
lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  yaml = {
    schemastore = {
      -- You must disable built-in schemaStore support if you want to use
      -- this plugin and its advanced options like `ignore`.
      enable = false,
      -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      url = "",
    },
    schemas = require("schemastore").yaml.schemas(),
  },
}

-- Lua
lspconfig.lua_ls.setup {
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
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}

lspconfig.prismals.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- configure gopls server
lspconfig.gopls.setup {
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
}

--[[ -- emmet ]]
--[[ lspconfig.emmet_ls.setup { ]]
--[[   capabilities = capabilities, ]]
--[[   on_attach = on_attach, ]]
--[[   filetype = { "html", "typescript", "typescriptreact", "javascript", "javascriptreact", "ts", "tsx" }, ]]
--[[ } ]]

-- typescript
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    perferences = {
      disableSuggestions = true,
    },
  },
}

-- tailwindcss
lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "astro",
    "astro-markdown",
    "html",
    --[[ "markdown", ]]
    --[[ "mdx", ]]
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
}

-- markdown
lspconfig.marksman.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "markdown", "markdown.mdx", "mdx" },
}

-- mdx
lspconfig.mdx_analyzer.setup {
  cmd = { "mdx-language-server", "--stdio" },
  filetypes = { "markdown.mdx", "mdx" },
}

-- python pyright
lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetype = { "python" },
}

-- rust tools
local ok4, rust_tools = pcall(require, "rust-tools")
if not ok4 then
  return
end

rust_tools.setup {
  server = {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      vim.keymap.set("n", "<leader>ldd", ":RustDebuggables <CR>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>lh", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<leader>la", ":CodeActionMenu<CR>", { buffer = bufnr })
      --[[ vim.keymap.set("n", "<leader>la", rust_tools.code_action_group.code_action_group, { buffer = bufnr }) ]]
    end,
  },

  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
}

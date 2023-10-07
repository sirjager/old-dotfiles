local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

vim.filetype.add {
  extension = {
    mdx = "mdx",
  },
}

vim.treesitter.language.register("markdown", "mdx")

ts.setup {
  ensure_installed = {
    "bash",
    "css",
    "csv",
    "go",
    "gomod",
    "gosum",
    "html",
    "http",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "prisma",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },

  -- Install parsers syncronously (only applicable to `ensure_installed`)
  sync_install = false,
  auto_install = true,

  playground = { enable = true },

  markid = { enable = true },

  indent = { enable = true },

  highlights = {
    enable = true,
    use_languagetree = true,
  },

  autotag = {
    enable = true,
    filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "markdown", "mdx" },
  },

  refactor = {
    highlight_current_scope = {
      enable = true,
    },

    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~101.
    },

    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },

    navigation = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<A->",
        goto_previous_usage = "<A-<",
      },
    },

    indent = {
      enable = true,
      disable = {
        "yaml",
      },
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  },

  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
    },
  },
}

local ok, pkg = pcall(require, "catppuccin")
if not ok then
  return
end

pkg.setup {
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "red",
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.3, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = { "italic" },
    loops = { "italic" },
    functions = { "italic" },
    --[[ keywords = {}, ]]
    strings = { "italic" },
    --[[ variables = {''}, ]]
    --[[ numbers = { "bold" }, ]]
    --[[ booleans = { "bold" }, ]]
    --[[ properties = {}, ]]
    --[[ types = { "bold" }, ]]
    --[[ operators = {}, ]]
  },
  --[[ color_overrides = {}, ]]
  --[[ custom_highlights = {}, ]]
  integration_default = nil, -- set to true/false to enable/disable integrations by default
  -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    mini = false,
    barbar = false,
    alpha = true,
    markdown = true,
    which_key = true,
    telescope = {
      enabled = true,
      --[[ style = "nvchad", ]]
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
  },
}

local opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymaps = {
  n = {
    -- clear highlights
    ["<Esc>"] = { ":noh <CR>", "clear highlights" },

    -- disabling recording:
    ["q"] = { "<ESC><ESC>:noh<CR>", "clear highlights" },

    -- select all text in current buffer
    ["<C-a>"] = { "gg<S-v>G", "select all" },

    -- save buffers
    ["<C-s>"] = { ":w<CR>", "save buffer" },

    -- close buffers
    ["<C-w>"] = { "<Cmd>BufferClose<CR>", "close buffer" },

    -- new buffer
    ["<C-n>"] = { "<Cmd>enew<CR>", "new buffer" },

    -- toogle line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

    -- rust crates
    ["<leader>rcu"] = { ":lua require'crates'.upgrade_all_crates()<CR>", "rust update crates" },

    -- Resize windows with arrows
    ["<C-Up>"] = { ":resize +2<CR>", "increase window height" },
    ["<C-Down>"] = { ":resize -2<CR>", "decrease window height" },
    ["<C-Left>"] = { ":vertical resize -2<CR>", "decrease window width" },
    ["<C-Right>"] = { ":vertical resize +2<CR>", "increase window width" },

    ["<S-h>"] = { ":vertical resize -2<CR>", "decrease window width" },
    ["<S-l>"] = { ":vertical resize +2<CR>", "increase window width" },
    ["<S-j>"] = { ":resize -2<CR>", "decrease window height" },
    ["<S-k>"] = { ":resize +2<CR>", "increase window height" },

    -- tabs by barbar plugin
    ["<A-p>"] = { "<Cmd>BufferPin<CR>", "pin buffer" },
    ["<A-i>"] = { "<Cmd>BufferPick<CR>", "smart buffer picker" },

    -- fast swtich tabs
    ["<A-1>"] = { "<Cmd>BufferGoto 1<CR>", "go to 1 buffer" },
    ["<A-2>"] = { "<Cmd>BufferGoto 2<CR>", "go to 2 buffer" },
    ["<A-3>"] = { "<Cmd>BufferGoto 3<CR>", "go to 3 buffer" },
    ["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", "go to 4 buffer" },
    ["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", "go to 5 buffer" },
    ["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", "go to 6 buffer" },
    ["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", "go to 7 buffer" },
    ["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", "go to 8 buffer" },
    ["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", "go to 9 buffer" },
    ["<A-0>"] = { "<Cmd>BufferLast<CR>", "go to last buffer" },

    -- split windows horizontally and vertically
    ["<A-s>l"] = { ":vsplit<CR><C-w>w", "split window right" },
    ["<A-s>j"] = { ":split<CR><C-w>w", "split window down" },

    -- maximize window and restore window
    ["<A-f>"] = { ":MaximizerToggle<CR>", "maximize / restore window" },

    -- toggle zen mode
    ["<A-z>"] = { ":ZenMode<CR>", "toggle zen mode" },

    -- go lang specific
    ["<leader>gsj"] = { "<CMD> GoTagAdd json <CR>", "go: add json struct tags" },
    ["<leader>gsy"] = { "<CMD> GoTagAdd yaml <CR>", "go: add yaml struct tags" },
  },

  -- insert mode
  i = {
    -- faster escape insert mode with: jk/kj
    ["jk"] = { "<ESC>", "escape insert mode" },
    ["kj"] = { "<ESC>", "escape insert mode" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },

    -- save buffer
    ["<C-s>"] = { "<ESC>:w<CR>", "save buffer" },
  },

  -- visual mode
  v = {
    -- keep last copied in clipboard
    ["p"] = { '"_dp', "paste last copied" },

    -- move selection left, right, top, bottom
    ["H"] = { "<gv", "indent left" },
    ["L"] = { ">gv", "indent right" },
    ["J"] = { ":move '>+1<CR>gv-gv", "move selection down" },
    ["K"] = { ":move '<-2<CR>gv-gv", "move selection up" },
  },

  -- terminal
  t = {},
}

local which_keymaps = {

  e = { ":NvimTreeFindFileToggle<CR>", "toggle file explorer" },

  m = {
    name = "database client",
    m = { ":DBUIToggle<CR>", "database ui toggle" },
    c = { ":DBUIClose<CR>", "database ui close" },
  },

  t = {
    name = "toggle",

    w = {
      name = "wrap long lines",
      r = { ":set wrap <CR>", "wrap long lines" },
      n = { ":set nowrap <CR>", "nowrap long lines" },
    },

    l = {
      name = "line numbers",
      n = { "<cmd> set nu! <CR>", "toggle line number" },
      r = { "<cmd> set rnu! <CR>", "toggle relative number" },
    },

    t = {
      name = "toggle terminal",
      f = { ":ToggleTerm direction=float<CR>", "terminal on float" },
      l = { ":ToggleTerm direction=vertical size=80<CR>", "terminal on right" },
      j = { ":ToggleTerm direction=horizontal size=8<CR>", "terminal on left" },
    },
  },

  s = {
    name = "search",
    s = { ":Telescope find_files hidden=true <CR>", "find files" }, -- most used
    w = { ":Telescope live_grep <CR>", "live grep" },
    o = { ":Telescope oldfiles <CR>", "recent files" },
    p = { ":Telescope project <CR>", "open project" },
    r = { ":Telescope resume <CR>", "resume search" },
    W = { ":Telescope current_buffer_fuzzy_find <CR>", "find word" },
    h = { ":Telescope help_tags <CR>", "help tags" },
    c = { ":Telescope colorschemes <CR>", "color schemes" },
    a = { ":Telescope autocommands <CR>", "auto commands" },
    C = { ":Telescope commands <CR>", "list commands" },
  },

  d = {
    name = "diagnostic",
    d = { ":Lspsaga show_buf_diagnostics <CR>", "buf diagnostics" }, -- most used
    w = { ":Lspsaga show_workspace_diagnostics <CR>", "workspace diagnostics" },
    l = { ":Lspsaga show_line_diagnostics <CR>", "line diagnostics" },
    j = { ":Lspsaga diagnostic_jump_next <CR>", "next diagnostic" },
    k = { ":Lspsaga diagnostic_jump_prev <CR>", "prev diagnostic" },
    c = { ":Lspsaga show_cursor_diagnostics <CR>", "cursor diagnostics" },
  },

  l = {
    name = "lsp",
    i = { ":LspInfo<CR>", "lsp info" },
    h = { ":Lspsaga hover_doc <CR>", "hover doc" }, -- most used 1
    a = { ":CodeActionMenu<CR>", "code action" }, -- most used 2
    o = { ":Lspsaga outline <CR>", "outline" },
    r = { ":Lspsaga rename <CR>", "rename" },
    R = { ":Lspsaga project_replace <CR>", "project replace" },

    l = {
      name = "def,impl,decl,types",
      d = { ":Lspsaga peek_definition <CR>", "peek definitions" }, -- most used
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "implementation" },
      D = { ":Lspsaga goto_definition <CR>", "goto definitions" },
      t = { ":Lspsaga peek_type_definition <CR>", "peek type definitions" },
      T = { ":Lspsaga goto_type_definition <CR>", "goto type definitions" },
    },

    c = {
      name = "calls",
      i = { ":Lspsaga incoming_calls <CR>", "incoming calls" },
      o = { ":Lspsaga outgoing_calls <CR>", "outgoing calls" },
    },

    d = {
      name = "debugging",
      b = { "<cmd> DapToggleBreakpoint <CR>", "toggle breakpoint" },
      c = { "<cmd> DapContinue <CR>", "debug continue" },
      t = { "<cmd> DapTerminate <CR>", "debug terminate" },
      l = { "<cmd> DapShowLog <CR>", "debug show log" },
      i = { "<cmd> DapStepInto <CR>", "debug step into" },
      j = { "<cmd> DapStepOver <CR>", "debug step over" },
      o = { "<cmd> DapStepOut <CR>", "debug step out" },
      u = {
        function()
          local widgets = require "dap.ui.widgets"
          local sidebar = widgets.sidebar(widgets.scopes)
          sidebar.open()
        end,
        "open debug sidebar",
      },
    },
  },
}

--
for mode, mappings in pairs(keymaps) do
  for key, mapping in pairs(mappings) do
    local cmd = mapping[1]
    --[[ local desc = mapping[2] ]]
    vim.api.nvim_set_keymap(mode, key, cmd, opts)
  end
end

-- which key mappings:
local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

-- default which-key opts: https://github.com/folke/which-key.nvim
local which_key_opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = false, -- use `expr` when creating keymaps
}

wk.register(which_keymaps, which_key_opts)

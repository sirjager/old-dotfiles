local kind = require("user.core.kind")
local wk = lvim.builtin.which_key
local nm = lvim.keys.normal_mode
local im = lvim.keys.insert_mode
local vm = lvim.keys.visual_mode

-- close /kill buffer
nm["<C-w>"] = ":BufferClose<CR>"
nm["<A-w>"] = ":BufferKill<CR>"

-- select all
nm["<C-a>"] = "<ESC>gg<S-v>G"

-- clear search higlight
nm["<leader>h"] = ":nohl<CR>"

-- save buffer
nm["<C-s>"] = ":w<CR>"
im["<C-s>"] = "<ESC><ESC>:w<CR>"

-- Escape insert mode
im["jk"] = "<ESC><ESC>"
im["kj"] = "<ESC><ESC>"

-- split pane horizontally and vertically 
nm["<A-s>l"] = "<ESC><ESC>:vsplit<CR><C-w>w"
nm["<A-s>j"] = "<ESC><ESC>:split<CR><C-w>w"

-- move line or selection up or down
nm["A-j"] = ":move '>+1<CR>gv-gv"
vm["A-j"] = ":move '>+1<CR>gv-gv"
vm["A-k"] = ":move '<-2<CR>gv-gv"
nm["A-k"] = ":move '<-2<CR>gv-gv"

-- indent line or selection
vm["<S-h>"] = "<gv"
vm["<S-l>"] = ">gv"

-- switch tabs / buffers
nm["<A-q>"] = ":BufferLineTogglePin<CR>"
nm["<A-p>"] = ":BufferLinePick<CR>"
nm["<A-h>"] = ":BufferLineCyclePrev<CR>"
nm["<A-l>"] = ":BufferLineCycleNext<CR>"

-- sitch buffers using numbers
nm["<A-1>"] = ":BufferGoto 1<CR>"
nm["<A-2>"] = ":BufferGoto 2<CR>"
nm["<A-3>"] = ":BufferGoto 3<CR>"
nm["<A-4>"] = ":BufferGoto 4<CR>"
nm["<A-5>"] = ":BufferGoto 5<CR>"
nm["<A-6>"] = ":BufferGoto 6<CR>"
nm["<A-7>"] = ":BufferGoto 7<CR>"
nm["<A-8>"] = ":BufferGoto 8<CR>"
nm["<A-9>"] = ":BufferGoto 9<CR>"
nm["<A-0>"] = ":BufferLast <CR>"

-- resize panes
nm["<C-Up>"] = ":resize +2<CR>"
nm["<C-Down>"] = ":resize -2<CR>"
nm["<C-Left>"] = ":vertical resize -2<CR>"
nm["<C-Right>"] = ":vertical resize +2<CR>"

-- Telescope
nm["<C-p><C-p>"] = ":Telescope find_files <CR>"
nm["<C-p><C-o>"] = ":Telescope oldfiles <CR>"
nm["<C-p><C-l>"] = ":Telescope live_grep <CR>"
nm["<C-p><C-h>"] = ":Telescope help_tags <CR>"
nm["<C-p><C-g>"] = ":LazyGit <CR>"

-- maximize / restore current window
nm["<A-f><A-f>"] = ":MaximizerToggle<CR>"

nm["<A-->"] = ":ToggleTerm direction=horizontal size=8 <CR>"
nm["<A-_>"] = ":ToggleTerm direction=vertical size=8 <CR>"

wk.mappings["l"]["t"] = { ":LvimToggleFormatOnSave<cr>", kind.symbols_outline.File .. " Toggle format-on-save" }
wk.mappings["l"]["R"] = { ":LspRestart<cr>", kind.icons.exit .. " Restart" }

wk.mappings["S"] = {
  name = "+Persistence",
  s = { "<cmd>lua require('persistence').load()<cr>", kind.icons.clock .. " Reload Last Session For Dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", kind.icons.clock .. " Restore Last Session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", kind.icons.exit .. " Quit Without Saving Session" },
}


wk.mappings["t"] = {
  name = "+Telescope",
  r = { ":Telescope oldfiles <CR>", "Recent Files" },
  f = { ":Telescope find_files <CR>", "Find Files" },
  l = { ":Telescope live_grep <CR>", "Live Grep" },
  h = { ":Telescope help_tags <CR>", "Help Tags" },
}

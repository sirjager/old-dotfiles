local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymaps = {
	-- normal mode
	n = {
		["<leader>rr"] = { ":luafile %<CR>", "Hotreload neovim configs", opts = opts },
		-- clear current search hightlights
		["<leader>nh"] = { ":nohl<CR>", "clear the current search highlight", opts = opts },

		-- select all text in current buffer
		["<C-a>"] = { "gg<S-v>G", "select all", opts = opts },

		-- handled by tmux : better window navigation
		-- ["<C-h>"] = { "<C-w>h", "focus window left", opts = opts },
		-- ["<C-j>"] = { "<C-w>j", "focus window down", opts = opts },
		-- ["<C-k>"] = { "<C-w>k", "focus window up", opts = opts },
		-- ["<C-l>"] = { "<C-w>l", "focus window right", opts = opts },

		-- nvim tree (file explorer)
		["<leader>e"] = { ":NvimTreeFindFileToggle<CR>", "toggle file explorer", opts = opts },

		-- Resize windows with arrows
		["<C-Up>"] = { ":resize +2<CR>", "increase window height", opts = opts },
		["<C-Down>"] = { ":resize -2<CR>", "decrease window height", opts = opts },
		["<C-Left>"] = { ":vertical resize -2<CR>", "decrease window width", opts = opts },
		["<C-Right>"] = { ":vertical resize +2<CR>", "increase window width", opts = opts },

		-- telescope prefix =  ctrl(hold) + p --> ctrl(hold) + key
		["<c-p><c-o>"] = { ":Telescope oldfiles <CR>", "recent files", opts = opts },
		["<c-p><c-p>"] = { ":Telescope find_files <CR>", "find files", opts = opts },
		["<c-p><c-g>"] = { ":Telescope live_grep <CR>", "live grep", opts = opts },
		["<c-p><c-h>"] = { ":Telescope help_tags <CR>", "help tags", opts = opts },
		["<c-g><c-g>"] = { ":LazyGit <CR>", "lazy git", opts = opts },

		-- tabs by barbar plugin
		["<A-q>"] = { "<Cmd>BufferPin<CR>", "pin buffer", opts = opts },
		["<A-p>"] = { "<Cmd>BufferPick<CR>", "smart buffer picker", opts = opts },
		["<A-h>"] = { "<Cmd>BufferPrevious<CR>", "swith to prev buffer", opts = opts },
		["<A-l>"] = { "<Cmd>BufferNext<CR>", "swith to next buffer", opts = opts },
		-- fast swtich tabs
		["<A-1>"] = { "<Cmd>BufferGoto 1<CR>", "go to 1 buffer", opts = opts },
		["<A-2>"] = { "<Cmd>BufferGoto 2<CR>", "go to 2 buffer", opts = opts },
		["<A-3>"] = { "<Cmd>BufferGoto 3<CR>", "go to 3 buffer", opts = opts },
		["<A-4>"] = { "<Cmd>BufferGoto 4<CR>", "go to 4 buffer", opts = opts },
		["<A-5>"] = { "<Cmd>BufferGoto 5<CR>", "go to 5 buffer", opts = opts },
		["<A-6>"] = { "<Cmd>BufferGoto 6<CR>", "go to 6 buffer", opts = opts },
		["<A-7>"] = { "<Cmd>BufferGoto 7<CR>", "go to 7 buffer", opts = opts },
		["<A-8>"] = { "<Cmd>BufferGoto 8<CR>", "go to 8 buffer", opts = opts },
		["<A-9>"] = { "<Cmd>BufferGoto 9<CR>", "go to 9 buffer", opts = opts },
		["<A-0>"] = { "<Cmd>BufferLast<CR>", "go to last buffer", opts = opts },

		-- save and close buffers
		["<C-s>"] = { ":w<CR>", "save buffer", opts = opts },
		["<A-w>"] = { "<Cmd>BufferClose<CR>", "close buffer", opts = opts },

		-- split windows horizontally and vertically
		["<A-s>l"] = { ":vsplit<CR><C-w>w", "split window right", opts = opts },
		["<A-s>j"] = { ":split<CR><C-w>w", "split window down", opts = opts },

		-- maximize window and restore window
		["<A-f><A-f>"] = { ":MaximizerToggle<CR>", "maximize / restore window", opts = opts },

		-- toggle terinal
		["<leader>tf"] = { ":ToggleTerm direction=float<CR>", "terminal on float", opts = opts },
		["<leader>tl"] = { ":ToggleTerm direction=vertical size=80<CR>", "terminal on right", opts = opts },
		["<leader>tj"] = { ":ToggleTerm direction=horizontal size=8<CR>", "terminal on left", opts = opts },

		-- go lang specific
		["<leader>gsj"] = { "<CMD> GoTagAdd json <CR>", "go: add json struct tags", opts = opts },
		["<leader>gsy"] = { "<CMD> GoTagAdd yaml <CR>", "go: add yaml struct tags", opts = opts },
	},

	-- insert mode
	i = {
		-- faster escape insert mode with: jk
		["jk"] = { "<ESC>", "escape insert mode", opts = opts },

		-- save buffer
		["<C-s>"] = { "<ESC>:w<CR>", "save buffer", opts = opts },

		-- split windows horizontally and vertically
		["<A-s>l"] = { "<ESC>:vsplit<CR><C-w>w", "split window right", opts = opts },
		["<A-s>j"] = { "<ESC>:split<CR><C-w>w", "split window down", opts = opts },
	},

	-- visual mode
	v = {
		-- stay in indent mode
		["<"] = { "<gv", "indent left", opts = opts },
		[">"] = { ">gv", "indent right", opts = opts },

		-- keep last copied in clipboard
		["p"] = { '"_dp', "paste last copied", opts = opts },
	},

	-- visual block
	x = {
		-- move selection up or down
		["J"] = { ":move '>+1<CR>gv-gv", "move selection down", opts = opts },
		["K"] = { ":move '<-2<CR>gv-gv", "move selection up", opts = opts },

		["A-j"] = { ":move '>+1<CR>gv-gv", "move selection up", opts = opts },
		["A-k"] = { ":move '<-2<CR>gv-gv", "move selection up", opts = opts },
	},

	-- terminal
	t = {
		-- handled by tmux : better terminal navigation
		-- ["C-h"] =  { "<C-\\><C-N><C-w>h" , "focus left", opts = opts },
		-- ["C-j"] =  { "<C-\\><C-N><C-w>j" , "focus down", opts = opts },
		-- ["C-k"] =  { "<C-\\><C-N><C-w>k" , "focus up", opts = opts },
		-- ["C-l"] =  { "<C-\\><C-N><C-w>l" , "focus right", opts = opts },
	},
}

for mode, mappings in pairs(keymaps) do
	for key, mapping in pairs(mappings) do
		local cmd = mapping[1]
		--[[ local desc = mapping[2] ]]
		local options = mapping.opts or {}
		vim.api.nvim_set_keymap(mode, key, cmd, options)
	end
end

local ok1, cmp = pcall(require, "cmp")
if not ok1 then
	return
end

local ok2, luasnip = pcall(require, "luasnip")
if not ok2 then
	return
end

local ok3, lspkind = pcall(require, "lspkind")
if not ok3 then
	return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete()), -- autocomple suggestion popupmenu toggle
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),

		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),

	formatting = {
		expandable_indicator = true,
		fields = { "menu", "kind", "abbr" }, -- rearrange positions if needed
		-- configure lspkind for vs-code like icons
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},

	-- sources for autocompletion, priorties from top to bottom order
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
		{ name = "crates" }, -- rust package manager
	}),

	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},

	window = {
		documentation = cmp.config.window.bordered({
			border = "single",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
		}),
	},

	experimental = {
		ghost_text = false,
	},
})

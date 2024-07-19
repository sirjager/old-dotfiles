LAZY_PLUGIN_SPEC = {}

---@diagnostic disable-next-line: lowercase-global
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- require "dope.init"
require "dope.options"
require("dope.keymaps").setup()
spec("dope.core.notify")

spec "dope.colorscheme"
spec "dope.core.alpha"
spec "dope.core.windline"
spec "dope.core.bufferline"
spec "dope.whichkey"

spec "dope.core.devicons"
spec "dope.core.neotree"
spec "dope.core.illuminate"
spec "dope.core.telescope"
spec "dope.core.tmuxnavigator"

spec "dope.lsps.treesitter"
spec "dope.lsps.mason"
spec "dope.lsps.schemastore"
spec "dope.lsps.lspconfig"
spec "dope.lsps.lspsaga"
spec "dope.lsps.none-ls"
spec "dope.lsps.comments"
spec "dope.lsps.cmp"

spec "dope.core.noice"
spec "dope.core.gitsigns"
spec "dope.lsps.ufo"

spec "dope.lsps.surround"
spec "dope.lsps.autopairs"
spec "dope.lsps.autotags"

spec "dope.core.obsidian"

spec "dope.xtra.codeium"
spec "dope.xtra.flash"
-- spec "dope.xtra.zenmode"
-- spec "dope.xtra.twilight"

require "dope.lazy"

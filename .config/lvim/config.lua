-- installs all plugins first (recommended)
reload("user.plugins")

-- plugins configurations 
reload("user.plugconf")

-- lsp configurations 
reload("user.core.lsp")

-- lunar plugins configurations
reload("user.core.lunar")

-- appearance / theme configurations
reload("user.core.colorscheme")

-- neovim tweaked options 
reload("user.core.options")

-- custom keybindings 
reload("user.core.keymaps")

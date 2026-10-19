-- Set leader keys before loading any mappings or plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.filetypes")
require("config.diagnostics")
require("config.venv")
require("plugins")

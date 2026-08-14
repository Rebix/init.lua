vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"
vim.opt.isfname:append("@-@")
-- vim.opt.guicursor = ""
vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"

vim.opt.cmdheight = 0

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		severity = nil, -- Show all severities (Error, Warn, Info, Hint)
-- 		source = "if_many", -- Show source (e.g., ts_ls, eslint) if multiple LSPs are active
-- 		prefix = "■",
-- 	},
-- 	float = {
-- 		border = "rounded",
-- 		source = "always",
-- 	},
-- })


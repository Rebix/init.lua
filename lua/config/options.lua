vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.guicursor = ""

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0

vim.opt.wrap = false

local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.isfname:append("@-@")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true

vim.opt.scrolloff = 8

vim.opt.timeoutlen = 500
vim.opt.updatetime = 300

vim.opt.autoread = true

vim.opt.confirm = true

vim.opt.mouse = "a"

vim.opt.colorcolumn = "100"

vim.opt.showmatch = true
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.fillchars = { eob = " " }

-- Reuse the explorer window, hide its banner, and size explorer splits at 25%.
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

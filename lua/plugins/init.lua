local github = function(repository)
  return "https://github.com/" .. repository
end

local build_group = vim.api.nvim_create_augroup("plugin_builds", { clear = true })

vim.api.nvim_create_autocmd("PackChanged", {
  group = build_group,
  callback = function(event)
    local data = event.data
    if data.spec.name ~= "telescope-fzf-native.nvim" then
      return
    end

    if data.kind ~= "install" and data.kind ~= "update" then
      return
    end

    if vim.fn.executable("make") == 0 then
      vim.notify("telescope-fzf-native requires make; using Telescope's built-in sorter", vim.log.levels.WARN)
      return
    end

    local result = vim.system({ "make" }, { cwd = data.path, text = true }):wait()
    if result.code ~= 0 then
      vim.notify("Failed to build telescope-fzf-native:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
    end
  end,
})

vim.pack.add({
  github("nvim-lua/plenary.nvim"),
  github("nvim-treesitter/nvim-treesitter"),
  github("NMAC427/guess-indent.nvim"),
  github("nvim-telescope/telescope.nvim"),
  github("nvim-telescope/telescope-fzf-native.nvim"),
  { src = github("ThePrimeagen/harpoon"), version = "harpoon2" },
  github("mbbill/undotree"),
  github("folke/which-key.nvim"),
  github("lewis6991/gitsigns.nvim"),
  github("rebelot/kanagawa.nvim"),
  github("mason-org/mason.nvim"),
  github("neovim/nvim-lspconfig"),
  github("mason-org/mason-lspconfig.nvim"),
  github("WhoIsSethDaniel/mason-tool-installer.nvim"),
  github("stevearc/conform.nvim"),
}, { confirm = false, load = true })

require("plugins.colorscheme")
require("plugins.treesitter")
require("plugins.guess-indent")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.undotree")
require("plugins.gitsigns")
require("plugins.lsp")
require("plugins.formatting")
require("plugins.which-key")

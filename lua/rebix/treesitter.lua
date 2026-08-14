local parsers = {
	"lua",
	"vim",
	"vimdoc",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"gitignore",
}

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  {
      src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
      version = "main",
  },
})

require("nvim-treesitter").install(parsers)

local group = vim.api.nvim_create_augroup("RebixTreesitter", {
	clear = true,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	group = group,
	callback = function()
		if vim.bo.buftype ~= "" then
			return
		end

		pcall(vim.treesitter.start, 0)
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
		},
	},
})

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		init = function()
			local parsers = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"json",
				"gitignore",
				"go",
			}

			local group = vim.api.nvim_create_augroup("ThePrimeagenTreesitter", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
				group = group,
				callback = function()
					if vim.bo.buftype ~= "" then
						return
					end

					pcall(vim.treesitter.start, 0)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "VeryLazy",
				once = true,
				callback = function()
					require("nvim-treesitter").install(parsers)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			})
		end,
	},
}

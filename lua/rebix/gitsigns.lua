vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("gitsigns").setup({
	current_line_blame = false,
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local opts = { buffer = bufnr }

		vim.keymap.set("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.nav_hunk("next")
			end)
			return "<Ignore>"
		end, vim.tbl_extend("force", opts, { expr = true, desc = "Next Git change" }))

		vim.keymap.set("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gitsigns.nav_hunk("prev")
			end)
			return "<Ignore>"
		end, vim.tbl_extend("force", opts, { expr = true, desc = "Previous Git change" }))

		vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, {
			buffer = bufnr,
			desc = "Preview Git change",
		})

		vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, {
			buffer = bufnr,
			desc = "Blame current line",
		})
	end,
})

vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

local todo = require("todo-comments")

todo.setup({
	signs = true,
	highlight = {
		comments_only = true,
		keyword = "wide",
		after = "fg",
	},
})

vim.keymap.set("n", "]t", todo.jump_next, {
	desc = "Next todo comment",
})

vim.keymap.set("n", "[t", todo.jump_prev, {
	desc = "Previous todo comment",
})

vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<cr>", {
	desc = "Search todo comments",
})

vim.keymap.set("n", "<leader>pT", "<cmd>TodoQuickFix<cr>", {
	desc = "Todo comments in quickfix",
})

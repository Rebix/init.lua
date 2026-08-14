-- Half-page scroll and re-center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search jumps and re-center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without copying" })

vim.keymap.set("n", "-", "<cmd>Ex<CR>")

vim.keymap.set("n", "<leader>r", function()
  dofile(vim.env.MYVIMRC)
  vim.notify("Neovim config reloaded")
end, { desc = "Reload Neovim config" })

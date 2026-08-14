vim.pack.add({
    { src = "https://github.com/folke/which-key.nvim" }
})

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end
)

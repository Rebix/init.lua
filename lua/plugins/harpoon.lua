local harpoon = require("harpoon")

harpoon:setup({})

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Add file" })

vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open file list" })

for index = 1, 4 do
  vim.keymap.set("n", "<leader>" .. index, function()
    harpoon:list():select(index)
  end, { desc = "Select file " .. index })
end

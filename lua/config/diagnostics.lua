vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
  virtual_text = false,
})

local show_inline = false

local function toggle_inline_diagnostics()
  show_inline = not show_inline
  vim.diagnostic.config({
    virtual_text = show_inline and { spacing = 2, source = "if_many" } or false,
  })
end

vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

vim.keymap.set("n", "<leader>dt", toggle_inline_diagnostics, { desc = "Toggle inline diagnostics" })

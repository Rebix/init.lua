local inline_text = { current_line = true, spacing = 2, source = "if_many" }
local show_inline = true

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
  -- Only the cursor line carries an inline message; <leader>dt hides them.
  virtual_text = inline_text,
  virtual_lines = false,
})

local function toggle_inline_diagnostics()
  show_inline = not show_inline
  vim.diagnostic.config({ virtual_text = show_inline and inline_text or false })
  vim.notify("inline diagnostics " .. (show_inline and "on" or "off"))
end

vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

vim.keymap.set("n", "<leader>dt", toggle_inline_diagnostics, { desc = "Toggle inline diagnostics" })

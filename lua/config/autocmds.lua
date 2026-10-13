vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 80 })
  end,
})

local function setup_cwd()
  local argv = vim.fn.argv()
  if #argv > 0 then
    local first_arg = argv[1]
    if vim.fn.isdirectory(first_arg) == 1 then
      vim.cmd("tcd " .. vim.fn.fnameescape(first_arg))
    end
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = setup_cwd,
  desc = "Set correct cwd",
})

-- Neovim ships no filetype for .mdx, which disables highlighting and formatting.
vim.filetype.add({ extension = { mdx = "mdx" } })
vim.treesitter.language.register("markdown", "mdx")

-- Prose filetypes read better with wrapping, spell checking and concealed markup.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("prose", { clear = true }),
  pattern = { "gitcommit", "markdown", "mdx", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

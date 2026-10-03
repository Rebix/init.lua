local conform = require("conform")

local prettier_filetypes = {
  css = true,
  graphql = true,
  html = true,
  javascript = true,
  javascriptreact = true,
  json = true,
  jsonc = true,
  less = true,
  markdown = true,
  ["markdown.mdx"] = true,
  scss = true,
  typescript = true,
  typescriptreact = true,
  yaml = true,
}

local tailwind_filetypes = {
  html = true,
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

local formatters_by_ft = {}
for filetype in pairs(prettier_filetypes) do
  formatters_by_ft[filetype] = tailwind_filetypes[filetype] and { "rustywind", "prettier" } or { "prettier" }
end

formatters_by_ft.python = { "ruff_organize_imports", "ruff_format" }
formatters_by_ft.lua = { "stylua" }

conform.setup({
  formatters_by_ft = formatters_by_ft,
  formatters = {
    rustywind = {
      args = { "--stdin", "--stdin-filename", "$FILENAME" },
    },
  },
  format_on_save = function(bufnr)
    if not formatters_by_ft[vim.bo[bufnr].filetype] then
      return
    end

    return {
      timeout_ms = 2000,
      lsp_format = "never",
    }
  end,
  notify_on_error = true,
  notify_no_formatters = true,
})

vim.keymap.set({ "n", "x" }, "<leader>lf", function()
  conform.format({
    async = false,
    timeout_ms = 2000,
    lsp_format = "never",
  })
end, { desc = "Format buffer or selection" })

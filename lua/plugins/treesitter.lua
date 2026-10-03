local treesitter = require("nvim-treesitter")

local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local started = pcall(vim.treesitter.start, args.buf)
    if started then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

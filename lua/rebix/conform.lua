vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" }
})

local prettier_ft = { "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
    format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
    },
    formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        lua = { "stylua" },
        javascript = prettier_ft,
        typescript = prettier_ft,
        javascriptreact = prettier_ft,
        typescriptreact = prettier_ft,
        json = prettier_ft,
    },
})

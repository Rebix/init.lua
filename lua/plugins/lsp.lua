local servers = {
  "vtsls",
  "tailwindcss",
  "eslint",
  "html",
  "cssls",
  "jsonls",
  "lua_ls",
  "basedpyright",
  "ruff",
}

require("mason").setup({})

-- Improve Lua support while editing this Neovim configuration.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

-- BasedPyright provides Python intelligence; Ruff owns linting and formatting.
vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})

require("mason-lspconfig").setup({
  automatic_enable = servers,
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "vtsls",
    "tailwindcss",
    "eslint",
    "html",
    "cssls",
    "jsonls",
    "lua_ls",
    "basedpyright",
    "ruff",
    "prettier",
    "rustywind",
    "stylua",
  },
  auto_update = false,
  run_on_start = true,
})

-- Use Neovim's built-in completion UI for attached language servers.
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "grr", vim.lsp.buf.references, "Go to references")
    map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "x" }, "gra", vim.lsp.buf.code_action, "Code action")
    map("n", "gO", vim.lsp.buf.document_symbol, "Document symbols")
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "<C-space>", vim.lsp.buf.signature_help, "Signature help")
    map("i", "<C-space>", vim.lsp.buf.signature_help, "Signature help")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
})

vim.keymap.set("i", "<C-s>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })

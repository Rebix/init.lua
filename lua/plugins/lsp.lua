local servers = {
  "astro",
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

-- BasedPyright provides Python intelligence
vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})

-- BasedPyright type-checks
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "standard",
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      classFunctions = { "cn", "clsx", "cva", "twMerge" },
    },
  },
})

require("mason-lspconfig").setup({
  automatic_enable = servers,
})

require("mason-tool-installer").setup({
  ensure_installed = {
    "astro",
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
  end,
})

local blink = require("blink.cmp")

blink.setup({
  keymap = {
    preset = "default",

    -- Enter accepts; Tab cycles the menu, then jumps snippet placeholders.
    ["<CR>"] = { "select_and_accept", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
  },

  -- Rank LSP, filesystem paths, snippets and buffer words in a single menu.
  sources = { default = { "lsp", "path", "snippets", "buffer" } },

  -- Keep item documentation visible while the menu is open.
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 200 },
  },

  -- Signature help while typing arguments; <C-k> toggles it.
  signature = { enabled = true },
})

vim.keymap.set("i", "<C-s>", function()
  blink.show()
end, { desc = "Trigger completion" })

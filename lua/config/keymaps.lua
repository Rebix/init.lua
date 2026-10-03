-- Yank with <Space>y to copy explicitly to the system clipboard.
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "<leader>p", vim.cmd.Ex, { desc = "Open file explorer" })

-- Move selected lines while keeping the selection and indentation.
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep the cursor in place when joining lines.
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- Keep the cursor centered while scrolling and navigating search results.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Paste over a selection without replacing the current yank register.
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without replacing register" })

-- Make Ctrl-C leave insert mode like Escape.
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

-- Navigate the quickfix list in the same direction as j and k.
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- Make the current file executable (macOS/Linux).
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

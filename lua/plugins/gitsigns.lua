require("gitsigns").setup({})

-- Jump between changed blocks; inside a diff keep using the built-in ]c/[c jumps.
vim.keymap.set("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    vim.cmd.Gitsigns("next_hunk")
  end
end, { desc = "Next git hunk" })

vim.keymap.set("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    vim.cmd.Gitsigns("prev_hunk")
  end
end, { desc = "Previous git hunk" })

-- Stage, unstage, and revert changes; in visual mode only the selected lines are affected.
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
vim.keymap.set("x", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage selected lines" })
vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Unstage last hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
vim.keymap.set("x", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset selected lines" })
vim.keymap.set("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage whole file" })
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset whole file" })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })

-- Inspect changes and history.
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame current line" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff against index" })
vim.keymap.set("n", "<leader>gD", "<cmd>Gitsigns diffthis ~<cr>", { desc = "Diff against last commit" })

-- Treat the hunk under the cursor as a text object: vih selects it, dih deletes it.
vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>", { desc = "Inner hunk" })

local run_git = function(args, on_success)
  local command = vim.list_extend({ "git" }, args)
  vim.system(command, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify(result.stderr or ("git " .. table.concat(args, " ") .. " failed"), vim.log.levels.ERROR)
        return
      end
      if on_success then
        on_success((result.stdout or ""):gsub("%s+$", ""))
      end
    end)
  end)
end

local commit = function(stage_first)
  vim.ui.input({ prompt = "Commit message: " }, function(message)
    if not message or message == "" then
      return
    end
    local do_commit = function()
      run_git({ "commit", "-m", message }, function(output)
        vim.notify("Committed:\n" .. output)
      end)
    end
    if stage_first then
      run_git(stage_first, do_commit)
    else
      do_commit()
    end
  end)
end

vim.keymap.set("n", "<leader>gc", function()
  commit()
end, { desc = "Commit staged changes" })

vim.keymap.set("n", "<leader>gC", function()
  commit({ "add", "-A" })
end, { desc = "Commit all changes" })

vim.keymap.set("n", "<leader>gP", function()
  run_git({ "push" }, function()
    vim.notify("Pushed.")
  end)
end, { desc = "Push to remote" })

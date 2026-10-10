local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- Use FZF-native when it is installed and compiled; otherwise use Telescope's sorter.
pcall(telescope.load_extension, "fzf")

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Find git changes" })

-- Switch projects via a Telescope menu listing every folder under the projects
-- directory (~/Projects or ~/Documents/Projects, whichever this machine has);
-- each project gets its own tab with its own working directory, and lands in
-- find-files.
vim.keymap.set("n", "<leader>fp", function()
  local dirs = {}
  for _, root in ipairs({ vim.env.HOME .. "/Projects", vim.env.HOME .. "/Documents/Projects" }) do
    if vim.fn.isdirectory(root) == 1 then
      for _, dir in ipairs(vim.fn.glob(root .. "/*", false, true)) do
        dir = dir:gsub("/+$", "")
        if dir ~= "" then
          table.insert(dirs, dir)
        end
      end
    end
  end
  table.sort(dirs)

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local telescope_config = require("telescope.config").values

  pickers.new({}, {
    prompt_title = "Switch project",
    finder = finders.new_table({ results = dirs }),
    sorter = telescope_config.generic_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not entry then
          return
        end
        local choice = entry.value or entry.display
        local buffer = vim.api.nvim_get_current_buf()
        local tab_is_fresh = #vim.api.nvim_list_wins() == 1
          and vim.api.nvim_buf_get_name(buffer) == ""
          and not vim.bo[buffer].modified
        if not tab_is_fresh then
          vim.cmd("tabnew")
        end
        vim.cmd("tcd " .. vim.fn.fnameescape(choice))
        builtin.find_files({ cwd = choice })
      end)
      return true
    end,
  }):find()
end, { desc = "Find project" })

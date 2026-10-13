local telescope = require("telescope")
local builtin = require("telescope.builtin")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local telescope_config = require("telescope.config").values

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

pcall(telescope.load_extension, "fzf")

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>F", builtin.live_grep, { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Find git changes" })

local function pick_project()
  local dirs = {}
  for _, root in ipairs({
    vim.env.HOME .. "/Projects",
    vim.env.HOME .. "/Documents/Projects",
  }) do
    if vim.fn.isdirectory(root) == 1 then
      for name, type in vim.fs.dir(root) do
        if type == "directory" then
          table.insert(dirs, root .. "/" .. name)
        end
      end
    end
  end

  -- nvim dir quick access
  table.insert(dirs, vim.env.HOME .. "/.config/nvim")
  table.sort(dirs)

  pickers
    .new({}, {
      prompt_title = "Switch project",
      finder = finders.new_table({ results = dirs }),
      sorter = telescope_config.generic_sorter({}),
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
    })
    :find()
end

vim.keymap.set("n", "<leader>fp", pick_project, { desc = "Find project" })

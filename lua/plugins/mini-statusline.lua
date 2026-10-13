-- Statusline via mini.statusline with a custom content function: filename on
the left; diagnostic counts, search count, macro recording, and the filetype
with its nerd font icon on the right.
local MiniStatusline = require("mini.statusline")
local MiniIcons = require("mini.icons")

MiniIcons.setup()

local diagnostic_config = {
  {
    severity = vim.diagnostic.severity.ERROR,
    icon = " ",
    hl = "DiagnosticError",
  },
  {
    severity = vim.diagnostic.severity.WARN,
    icon = " ",
    hl = "DiagnosticWarn",
  },
  {
    severity = vim.diagnostic.severity.HINT,
    icon = " ",
    hl = "DiagnosticHint",
  },
  {
    severity = vim.diagnostic.severity.INFO,
    icon = " ",
    hl = "DiagnosticInfo",
  },
}

local content = function()
  local filename = MiniStatusline.section_filename({ trunc_width = 9999 })
  local search = MiniStatusline.section_searchcount({ trunc_width = 0 })
  local mode = vim.bo.mode
  local recording = vim.fn.reg_recording()

  local groups = {
    -- Mode indicator (left side)
    {
      hl = "MiniStatuslineMode",
      strings = { MiniIcons.get("mode", mode) .. " " },
    },
    -- Filename
    {
      hl = "MiniStatuslineFilename",
      strings = { filename },
    },
    -- Separator
    {
      hl = "MiniStatuslineSeparator",
      strings = { "%=" },
    },
  }

  if vim.diagnostic.is_enabled({ bufnr = 0 }) then
    local counts = vim.diagnostic.count(0)

    for _, diagnostic in ipairs(diagnostic_config) do
      local count = counts[diagnostic.severity] or 0

      if count > 0 then
        table.insert(groups, {
          hl = diagnostic.hl,
          strings = { diagnostic.icon .. count },
        })
      end
    end
  end

  table.insert(groups, {
    hl = "MiniStatuslineSearch",
    strings = { search },
  })

  table.insert(groups, {
    hl = "MiniStatuslineRecording",
    strings = { recording ~= "" and "REC @" .. recording or "" },
  })

  table.insert(groups, {
    hl = "MiniStatuslineFiletype",
    strings = { MiniIcons.get("filetype", vim.bo.filetype) },
  })

  return MiniStatusline.combine_groups(groups)
end

MiniStatusline.setup({
  content = {
    active = content,
    inactive = content,
  },
})

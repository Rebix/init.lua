local MiniStatusline = require("mini.statusline")
local MiniIcons = require("mini.icons")

MiniIcons.setup({ colors = false })

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
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local filename = MiniStatusline.section_filename({ trunc_width = 120 })
  local search = MiniStatusline.section_searchcount({ trunc_width = 0 })
  local recording = vim.fn.reg_recording()

  local groups = {
    {
      hl = mode_hl,
      strings = { mode },
    },
    "%<",
    { hl = "MiniStatuslineFilename", strings = { filename } },
    "%=",
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
    hl = "MiniStatuslineFilename",
    strings = { search },
  })

  table.insert(groups, {
    hl = "DiagnosticWarn",
    strings = { recording ~= "" and "REC @" .. recording or "" },
  })

  if vim.bo.filetype ~= "" then
    local ok, icon, icon_hl = pcall(MiniIcons.get, "filetype", vim.bo.filetype)
    if ok then
      table.insert(groups, { hl = icon_hl, strings = { icon, vim.bo.filetype } })
    end
  end

  return MiniStatusline.combine_groups(groups)
end

MiniStatusline.setup({
  content = {
    active = content,
    inactive = content,
  },
})

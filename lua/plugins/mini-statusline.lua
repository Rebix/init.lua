-- Statusline via mini.statusline with a custom content function: filename on
-- the left; diagnostic counts, search count, macro recording, and the filetype
-- with its nerd font icon on the right.
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
  local recording = vim.fn.reg_recording()

  local groups = {
    filename,
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

  -- Filetype icon and name at the far right, joined by a single space inside
  -- one group so the icon's color covers both; skipped for buffers without a
  -- filetype.
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

for _, name in ipairs({ "StatusLine", "StatusLineNC", "MiniStatuslineFilename" }) do
  local fg = vim.api.nvim_get_hl(0, { name = name }).fg

  vim.api.nvim_set_hl(0, name, {
    fg = fg,
    bg = "NONE",
  })
end

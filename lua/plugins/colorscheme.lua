require("kanagawa").setup({
  transparent = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
})

local transparent_groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "FloatTitle",
  "FloatFooter",
  "LineNr",
  "LineNrAbove",
  "LineNrBelow",
  "CursorLineNr",
  "SignColumn",
  "FoldColumn",
  "StatusLine",
  "StatusLineNC",
  "WinBar",
  "WinBarNC",
  "MsgArea",
  "MsgSeparator",
  "Pmenu",
  "PmenuKind",
  "PmenuExtra",
  "PmenuSbar",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "TelescopePreviewNormal",
  "TelescopePreviewBorder",
  "WhichKeyNormal",
}

local function clear_background(group)
  local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
  highlight.bg = nil
  highlight.ctermbg = nil
  vim.api.nvim_set_hl(0, group, highlight)
end

function ColorMyPencils(color)
  color = color or "kanagawa-dragon"
  vim.cmd.colorscheme(color)

  for _, group in ipairs(transparent_groups) do
    clear_background(group)
  end
end

ColorMyPencils()

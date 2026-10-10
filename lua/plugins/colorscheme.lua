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
  "MiniStatuslineFilename",
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

local function apply_transparency()
  for _, group in ipairs(transparent_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    hl.bg = nil
    hl.ctermbg = nil
    vim.api.nvim_set_hl(0, group, hl)
  end
end

local function color_my_pencils(color)
  color = color or "kanagawa-dragon"
  vim.cmd.colorscheme(color)
  apply_transparency()
end

-- Re-apply after any colorscheme change (e.g. :colorscheme) so transparency stays centralized.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_transparency,
})

color_my_pencils()

return { apply = apply_transparency }

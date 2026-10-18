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

require("rose-pine").setup({
  variant = "moon",
  dark_variant = "moon",
  styles = {
    bold = true,
    italic = false,
    transparency = true,
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
  "BlinkCmpDoc",
  "BlinkCmpDocSeparator",
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

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("transparency", { clear = true }),
  callback = apply_transparency,
})

local function color_my_pencils(color)
  vim.cmd.colorscheme(color or "kanagawa-dragon")
end

color_my_pencils("rose-pine")

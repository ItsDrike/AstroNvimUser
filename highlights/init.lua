-- Add highlight groups in any theme
-- These definitions are passed directly to vim.api.nvim_set_hl(0, group, spec)
local highlights = {
  -- Spell
  SpellBad = { sp = "#ffbba6", undercurl = true },
  SpellCap = { sp = "#ffbba6", undercurl = true },
  SpellLocal = { sp = "#ffbba6", undercurl = true },
  SpellRare = { sp = "#ffbba6", undercurl = true },
  --VS code cmp colors
  CmpItemKindConstructor = { fg = "#f28b25" },
  CmpItemKindUnit = { fg = "#D4D4D4" },
  CmpItemKindProperty = { fg = "#D4D4D4" },
  CmpItemKindKeyword = { fg = "#D4D4D4" },
  CmpItemKindMethod = { fg = "#C586C0" },
  CmpItemKindFunction = { fg = "#C586C0" },
  CmpItemKindColor = { fg = "#C586C0" },
  CmpItemKindText = { fg = "#9CDCFE" },
  CmpItemKindInterface = { fg = "#9CDCFE" },
  CmpItemKindVariable = { fg = "#9CDCFE" },
  CmpItemKindField = { fg = "#9CDCFE" },
  CmpItemKindValue = { fg = "#9CDCFE" },
  CmpItemKindEnum = { fg = "#9CDCFE" },
  CmpItemKindEnumMember = { fg = "#9CDCFE" },
  CmpItemKindStruct = { fg = "#9CDCFE" },
  CmpItemKindReference = { fg = "#9CDCFE" },
  CmpItemKindTypeParameter = { fg = "#9CDCFE" },
  CmpItemKindSnippet = { fg = "#D4D4D4" },
  CmpItemKindClass = { fg = "#f28b25" },
  CmpItemKindModule = { fg = "#D4D4D4" },
  CmpItemKindOperator = { fg = "#D4D4D4" },
  CmpItemKindConstant = { fg = "#D4D4D4" },
  CmpItemKindFile = { fg = "#D4D4D4" },
  CmpItemKindFolder = { fg = "#D4D4D4" },
  CmpItemKindEvent = { fg = "#D4D4D4" },
  CmpItemAbbrMatch = { fg = "#18a2fe", bold = true },
  CmpItemAbbrMatchFuzzy = { fg = "#18a2fe", bold = true },
  CmpItemMenu = { fg = "#777d86" },
}

-- By default, the highlights specified above will completely override whatever previous
-- highlight definition that group had with specified new rules. Highlights specified here
-- will only update the existing definitions, overriding what was specified, but leaving
-- the rest unchanged.
-- These can't interfere with the above definitions!
local update_highlights = {
  -- Add cterm colors for usage from TTY
  -- 0: Black
  -- 1: Dark red
  -- 2: Dark green
  -- 3: Dark yellow (or brown)
  -- 4: Dark blue
  -- 5: Dark magenta
  -- 6: Dark cyan
  -- 7: Light gray (or white)
  -- 8: Gray (or bright black)
  -- 9: Red
  -- 10: Green
  -- 11: Yellow
  -- 12: Blue
  -- 13: Magenta
  -- 14: Cyan
  -- 15: White (or bright white)
  Conditional = { ctermfg = 5 },
  Comment = { ctermfg = 7 },
  Character = { ctermfg = 2 },
  Constant = { ctermfg = 11 },
  Identifier = { ctermfg = 14 },
  Type = { ctermfg = 14 },
  String = { ctermfg = 2 },
  Boolean = { ctermfg = 3 },
  Number = { ctermfg = 3 },
  Repeat = { ctermfg = 13 },
  Keyword = { ctermfg = 13 },
  Tag = { ctermfg = 9 },
  ["@property"] = { ctermfg = 9 },
  ["@variable"] = { ctermfg = 9 },
  ["@function"] = { ctermfg = 14 },
  ["@tag"] = { ctermfg = 9 },
}

for group, new_spec in pairs(update_highlights) do
  local current_spec = vim.api.nvim_get_hl_by_name(group, true)
  highlights[group] = vim.tbl_extend("keep", current_spec, new_spec)
end

return highlights

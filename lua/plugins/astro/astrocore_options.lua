-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon

    return require("astrocore").extend_tbl(opts, {
      options = {
        opt = { -- vim.opt.<key>
          number = true,
          relativenumber = false,
          signcolumn = "yes", -- always show the sign column even if there are no signs to be shown
          wrap = false, -- disable line wrapping
          linebreak = true, -- linebrake soft wrap at words
          spell = true, -- spell check everywhere (supports treesitter, so only comments/strings are chcked in most langs)
          listchars = {
            tab = get_icon "CharTab", -- Tab
            trail = get_icon "CharTrail", -- Trailing spaces
            nbsp = get_icon "CharNbsp", -- Non-breaking space
            extends = get_icon "CharExtends", -- Character to show in last column when wrap is off and line continues
            precedes = get_icon "CharPreceeds", -- Character to show in first column when there is text preceeding the first visible character
          },
          showbreak = get_icon("CharShowbreak", 1), -- String to put at the start of lines that have been wrapped.
        },
        g = { -- vim.g.<key>
        },
      },
    } --[[@as AstroCoreOpts]])
  end,
}

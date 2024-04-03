-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon

    return require("astrocore").extend_tbl(opts, {
      options = {
        opt = { -- vim.opt.<key>
          number = true,
          relativenumber = true,
          signcolumn = "auto", -- only show sign column if there are signs to be shown
          wrap = true, -- enable line wrapping
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
          -- configure global vim variables (vim.g)
          -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
          -- This can be found in the `lua/lazy_setup.lua` file
          markdown_fenced_languages = { -- Mappings for markdown fenced languages syntax
            "ts=typescript",
            "py=python",
          },
        },
      },
    } --[[@as AstroCoreOpts]])
  end,
}

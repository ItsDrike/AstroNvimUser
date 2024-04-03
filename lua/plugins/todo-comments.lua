-- This extends/overrides the definition of todo-comments plugin, adding some custom opts

return {
  "folke/todo-comments.nvim",
  dependencies = {
    {
      "AstroNvim/astroui",
      ---@type AstroUIOpts
      opts = {
        icons = {
          TodoFix = " ",
          TodoTodo = " ",
          TodoHack = " ",
          TodoWarn = " ",
          TodoPerf = " ",
          TodoNote = " ",
          TodoTest = "⏲ ",
        },
        text_icons = {
          TodoFix = "F ",
          TodoTodo = "T ",
          TodoHack = "H ",
          TodoWarn = "W ",
          TodoPerf = "P ",
          TodoNote = "N ",
          TodoTest = "T ",
        },
      },
    },
  },
  opts = function()
    local get_icon = require("astroui").get_icon
    local opts = {
      keywords = {
        FIX = {
          icon = get_icon "TodoFix", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = get_icon "TodoTodo", color = "info" },
        HACK = { icon = get_icon "TodoHack", color = "warning" },
        WARN = { icon = get_icon "TodoWarn", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = get_icon "TodoPerf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = get_icon "TodoNote", color = "hint", alt = { "INFO" } },
        TEST = { icon = get_icon "TodoTest", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },

      signs = vim.g.icons_enabled,
    }

    -- Use ripgrep if available, if not, fall back to grep
    opts.search = {}
    vim.fn.system "which rg" -- TODO: Check if astronvim has some util function for this
    if vim.v.shell_error == 1 then
      opts.search.command = "rg"
      opts.search.args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      }
    else
      opts.search.command = "grep"
      opts.search.args = {
        "--recursive", -- Note: This may be very slow when ran from dir with a lot of children
        "--color=never",
        "--with-filename",
        "--line-number",
        "--binary-files=without-match",
        "--byte-offset",
        '--exclude-dir=".*"',
        "--extended-regexp",
      }
    end

    return opts
  end,
}

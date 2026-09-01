---@type LazySpec
return {
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      local provider = require "astroui.status.provider"
      local percentage = provider.percentage()

      -- The community nvchad statusline omits cmd_info, which I don't like, as it
      -- contains things like macro recording status, it's confusing to not have that.
      -- This inserts it into the middle (centered) part of the status line.
      table.insert(opts.statusline, 7, status.component.cmd_info())

      -- Override the last element in the status-line, being the scroll information,
      -- which, for us, is the information from nvchad community statusline, which
      -- doesn't contain the col number, only vertical percentage, to include both.
      opts.statusline[#opts.statusline] = {
        status.component.builder {
          { provider = require("astroui").get_icon "ScrollText" },
          padding = { right = 1 },
          hl = { fg = "bg" },
          surround = {
            separator = "right",
            color = { main = "nav_icon_bg", left = "file_info_bg" },
          },
        },
        status.component.builder {
          padding = { left = 1 },
          {
            provider = function() return ("↔%d "):format(vim.fn.virtcol ".") end,
          },
          { provider = function() return "↕" .. percentage() end },
          surround = { separator = "none", color = "file_info_bg" },
        },
      }
    end,
  },
}

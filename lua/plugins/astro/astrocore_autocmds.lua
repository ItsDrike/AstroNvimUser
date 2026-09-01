---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    commands = {},
    autocmds = {
      resize_splits = {
        {
          event = "VimResized",
          callback = function() vim.cmd "tabdo wincmd =" end,
          desc = "Resize splits if window is resized",
        },
      },
      disable_spell_by_filetype = {
        {
          event = "FileType",
          pattern = { "toggleterm" },
          desc = "Disable spell checking for selected filetypes",
          callback = function() vim.opt_local.spell = false end,
        },
      },
      enable_wrap_for_prose = {
        {
          event = "FileType",
          pattern = { "markdown", "text" },
          desc = "Enable line wrapping for prose files",
          callback = function() vim.opt_local.wrap = true end,
        },
      },
    },
    -- Disable AstroNvim's custom hlsearch overrides
    on_keys = {
      auto_hlsearch = false,
    },
  },
}

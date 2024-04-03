---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    commands = {},
    autocmds = {
      resize_splits = {
        event = "VimResized",
        callback = function() vim.cmd "tabdo wincmd =" end,
        desc = "Resize splits if window is resized",
      },
      text_files = {
        event = "FileType",
        pattern = { "gitcommit", "markdown", "text" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end,
        desc = "Enable spellcheck and line wrap in text files",
      },
    },
    on_keys = {
      auto_hlsearch = false,
    },
  },
}

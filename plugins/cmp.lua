return {
  -- Extend/Override nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    -- Add additional completion sources
    dependencies = {
      "hrsh7th/cmp-calc", -- Quick calculator as completion source
      "f3fora/cmp-spell", -- Complation based on the words in spell list
      "hrsh7th/cmp-emoji", -- Emojis
    },
    opts = function(_, opts)
      local cmp = require "cmp"

      -- Specify source priorities, and include the new sources
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "calc", priority = 100 },
        { name = "emoji", priority = 50 },
        { name = "spell", priority = 25 },
      }
    end,
  },
}

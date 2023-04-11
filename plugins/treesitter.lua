return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      -- Except these
      --ignore_install = { "html" }
    },
  },

  -- Syntax aware text-objects, select, move, swap, and peek support.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true, -- lazy loaded by mini.ai
    dependencies = { "nvim-treesitter" },
  },

  -- View treesitter information directly in Neovim
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSHighlightCapturesUnderCursor",
      "TSPlaygroundToggle"
    },
    dependencies = { "nvim-treesitter" }
  },
}

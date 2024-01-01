return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      -- Except these
      --ignore_install = { "html" }
    },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
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
      "TSPlaygroundToggle",
    },
    dependencies = { "nvim-treesitter" },
  },

  -- Syntax highlighting, folds and filetype detection for Hyprland config files
  -- (Note: This doesn't install the `hypr` treesitter parser itself)
  {
    "luckasRanarison/tree-sitter-hypr",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter" },
  },
}

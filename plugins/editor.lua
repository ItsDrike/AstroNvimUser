return {
  -- Highlight references of token under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 120,
      -- Disable illuminate in these filetypes
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "neo-tree",
        "lazy",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
      -- illuminate the word under the cursor
      under_cursor = true,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      -- Set the keybinds after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          vim.keymap.set(
            "n",
            "]]",
            function() require("illuminate")["goto_next_reference"](false) end,
            { desc = "Next Reference", buffer = buffer }
          )
          vim.keymap.set(
            "n",
            "[[",
            function() require("illuminate")["goto_prev_reference"](false) end,
            { desc = "Prev Reference", buffer = buffer }
          )
        end,
      })
    end,
    keys = {
      { "]]", mode = { "n", "v" } },
      { "[[", mode = { "n", "v" } },
    },
  },

  -- Highlight function arguments
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter" }, -- specified in treesitter spec
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      excluded_argnames = {
        declarations = {},
        usages = {
          -- python = { "self", "cls" },
          -- lua = { "self', "_" }
        },
      },
    },
  },

  -- Search/Replace in multiple files
  {
    "windwp/nvim-spectre",
    event = "VeryLazy",
    config = true,
  },

  -- Pretty list showing diagnostics, references, telescope results, quickfix and location lists
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    cmd = {
      "Trouble",
      "TroubleToggle",
      "TroubleClose",
      "TroubleRefresh",
    },
    opts = function()
      local opts = {}
      if vim.g.icons_enabled then
        opts.icons = true
        opts.fold_open = ""
        opts.fold_closed = ""
        opts.indent_lines = true
      else
        opts.icons = false
        opts.fold_open = "V"
        opts.fold_closed = ">"
        opts.indent_lines = false
      end

      -- LSP signs already respects vim.g.icons_enabled
      -- just inherit sign symbols from those
      opts.use_diagnostic_signs = true

      return opts
    end,
  },

  -- Highlight todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "trouble.nvim" },
    version = "*",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>fT", "<cmd>TodoTelescope<CR>", desc = "Find Todos" },
    },
  },
}

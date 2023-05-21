return {
  -- Override some neo-tree settings
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = { ".github", ".gitignore" },
        },
      },
    },
  },

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
    opts = function()
      local opts = { search = {} }

      opts.search.command = "rg"
      opts.search.args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      }

      -- Fall back to regular grep if ripgrep isn't available
      vim.fn.system "which rg"
      if vim.v.shell_error == 1 then
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

      local icons
      if vim.g.icons_enabled then
        icons = {
          FIX = " ",
          TODO = " ",
          HACK = " ",
          WARN = " ",
          PERF = " ",
          NOTE = " ",
          TEST = "⏲ ",
        }
      else
        -- stylua removes trailing spaces in quotes
        -- stylua: ignore
        icons = {
          FIX = "F ",
          TODO = "T ",
          HACK = "H ",
          WARN = "W ",
          PERF = "P ",
          NOTE = "N ",
          TEST = "T ",
        }
      end

      opts.keywords = {
        FIX = {
          icon = icons.FIX, -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = icons.TODO, color = "info" },
        HACK = { icon = icons.HACK, color = "warning" },
        WARN = { icon = icons.WANR, color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = icons.PERF, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = icons.NOTE, color = "hint", alt = { "INFO" } },
        TEST = { icon = icons.TEST, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      }

      opts.signs = vim.g.icons_enabled

      return opts
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function(_, opts)
      -- The UTF character used for indent lines isn't supported in pure TTY,
      -- we could set it to pure ASCII char such as "|", however that looks weird as it has gaps,
      -- and is in the center of, not on a corner. Instead, we set it to an empty char, disabling
      -- indent guides visibility when in TTY
      if vim.g.tty then
        opts.char = ""
        opts.context_char = ""
      end
      require("indent_blankline").setup(opts)
    end,
  },
}

return {
  -- Override some neo-tree settings
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          always_show = {
            ".github",
            ".gitignore",
            ".env",
            ".pre-commit-config.yaml",
            ".flake8",
            ".gitlab-ci",
            "TODO",
          },
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
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    event = { "User AstroFile" },
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
      -- The configured character used for indent lines isn't supported in pure TTY,
      -- use a different supported character that looks slightly worse, but also does the trick
      if vim.g.tty then
        opts.char = "│"
        opts.context_char = "│"
      end
      require("indent_blankline").setup(opts)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function(_, opts)
      -- The configured characters used for indent git signs aren't supported in pure TTY
      -- use different supported characters that look slightly worse, but also do the trick
      if vim.g.tty then
        opts.signs.add.text = "│"
        opts.signs.change.text = "│"
        opts.signs.delete.text = "_"
        opts.signs.topdelete.text = "‾"
        opts.signs.changedelete.text = "~"
        opts.signs.untracked.text = "┆"
      end
      require("gitsigns").setup(opts)
    end,
  },

  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    opts = function()
      local actions = require "diffview.actions"
      local utils = require "astronvim.utils" --  astronvim utils

      local prefix = "<leader>D"

      utils.set_mappings {
        n = {
          [prefix] = { name = " Diff View" },
          [prefix .. "<cr>"] = { "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
          [prefix .. "h"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Open DiffView File History" },
          [prefix .. "H"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Open DiffView Branch History" },
        },
      }

      local build_keymaps = function(maps)
        local out = {}
        local i = 1
        for lhs, def in
          pairs(utils.extend_tbl(maps, {
            [prefix .. "q"] = { "<cmd>DiffviewClose<cr>", desc = "Quit Diffview" }, -- Toggle the file panel.
            ["]D"] = { actions.select_next_entry, desc = "Next Difference" }, -- Open the diff for the next file
            ["[D"] = { actions.select_prev_entry, desc = "Previous Difference" }, -- Open the diff for the previous file
            ["[C"] = { actions.prev_conflict, desc = "Next Conflict" }, -- In the merge_tool: jump to the previous conflict
            ["]C"] = { actions.next_conflict, desc = "Previous Conflict" }, -- In the merge_tool: jump to the next conflict
            ["Cl"] = { actions.cycle_layout, desc = "Cycle Diff Layout" }, -- Cycle through available layouts.
            ["Ct"] = { actions.listing_style, desc = "Cycle Tree Style" }, -- Cycle through available layouts.
            ["<leader>e"] = { actions.toggle_files, desc = "Toggle Explorer" }, -- Toggle the file panel.
            ["<leader>o"] = { actions.focus_files, desc = "Focus Explorer" }, -- Bring focus to the file panel
          }))
        do
          local opts
          local rhs = def
          local mode = { "n" }
          if type(def) == "table" then
            if def.mode then mode = def.mode end
            rhs = def[1]
            def[1] = nil
            def.mode = nil
            opts = def
          end
          out[i] = { mode, lhs, rhs, opts }
          i = i + 1
        end
        return out
      end

      return {
        enhanced_diff_hl = true,
        view = {
          merge_tool = { layout = "diff3_mixed" },
        },
        keymaps = {
          disable_defaults = true,
          view = build_keymaps {
            [prefix .. "o"] = { actions.conflict_choose "ours", desc = "Take Ours" }, -- Choose the OURS version of a conflict
            [prefix .. "t"] = { actions.conflict_choose "theirs", desc = "Take Theirs" }, -- Choose the THEIRS version of a conflict
            [prefix .. "b"] = { actions.conflict_choose "base", desc = "Take Base" }, -- Choose the BASE version of a conflict
            [prefix .. "a"] = { actions.conflict_choose "all", desc = "Take All" }, -- Choose all the versions of a conflict
            [prefix .. "0"] = { actions.conflict_choose "none", desc = "Take None" }, -- Delete the conflict region
          },
          diff3 = build_keymaps {
            [prefix .. "O"] = { actions.diffget "ours", mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget "theirs", mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          diff4 = build_keymaps {
            [prefix .. "B"] = { actions.diffget "base", mode = { "n", "x" }, desc = "Get Base Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "O"] = { actions.diffget "ours", mode = { "n", "x" }, desc = "Get Our Diff" }, -- Obtain the diff hunk from the OURS version of the file
            [prefix .. "T"] = { actions.diffget "theirs", mode = { "n", "x" }, desc = "Get Their Diff" }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          file_panel = build_keymaps {
            j = actions.next_entry, -- Bring the cursor to the next file entry
            k = actions.prev_entry, -- Bring the cursor to the previous file entry.
            o = actions.select_entry,
            S = actions.stage_all, -- Stage all entries.
            U = actions.unstage_all, -- Unstage all entries.
            X = actions.restore_entry, -- Restore entry to the state on the left side.
            L = actions.open_commit_log, -- Open the commit log panel.
            Cf = { actions.toggle_flatten_dirs, desc = "Flatten" }, -- Flatten empty subdirectories in tree listing style.
            R = actions.refresh_files, -- Update stats and entries in the file list.
            ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          file_history_panel = build_keymaps {
            j = actions.next_entry,
            k = actions.prev_entry,
            o = actions.select_entry,
            y = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
            L = actions.open_commit_log,
            zR = { actions.open_all_folds, desc = "Open all folds" },
            zM = { actions.close_all_folds, desc = "Close all folds" },
            ["?"] = { actions.options, desc = "Options" }, -- Open the option panel
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
          },
          option_panel = {
            q = actions.close,
            o = actions.select_entry,
            ["<cr>"] = actions.select_entry,
            ["<2-LeftMouse"] = actions.select_entry,
          },
        },
      }
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown" },
    opts = {},
  },
}

-- Adds vim-illuminate support
-- Mainly inheriting from astrocommunity import
--
-- For automatically highlighting other uses of the word under the cursor

return {
  {
    "AstroNvim/astrocommunity",

    { import = "astrocommunity.motion.mini-ai" },
  },

  {
    "RRethy/vim-illuminate",
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
}

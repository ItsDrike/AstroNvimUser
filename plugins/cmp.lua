return {
  -- Setup copilot.lua as cmp source
  -- (note: you'll want to run Copilot auth to login to github first)
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
        require("copilot_cmp").setup()
      end, 100)
    end,
  },

  -- Extend/Override nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    -- Add additional completion sources
    dependencies = {
      "hrsh7th/cmp-calc", -- Quick calculator as completion source
      "f3fora/cmp-spell", -- Complation based on the words in spell list
      "hrsh7th/cmp-emoji", -- Emojis
      -- "copilot-cmp", -- Github copilot (specified above)
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"

      -- Helper function, checking if there are any words before cursor
      -- (This is copied from AstroNvim source)
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      return require("astronvim.utils").extend_tbl(opts, {
        window = {
          completion = {
            border = "rounded",
            col_offset = -1,
            side_padding = 0,
          },
        },

        -- Specify source priorities, and include the new sources
        sources = cmp.config.sources {
          { name = "crates", priority = 1100 },
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "copilot", priority = 600 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
          { name = "calc", priority = 100 },
          { name = "emoji", priority = 50 },
          { name = "spell", priority = 25 },
        },

        -- Override snippet navigation to use <C-n> and <C-p>, completion selection (cycling
        -- through the options) selection to <C-j> an <C-k>, leaving <Tab> purely for confirming
        -- the completion.
        --
        -- This is done because AstroNvim by default follows the recommenede gives <Tab> too much functionality, which
        -- can cause issues. Especially with snippets, where a new snippet has a jumplist, and
        -- <Tab> being used to go to the next position in that jump list. However if the jumplist
        -- wasn't exhausted (we filled some of the things manually, or moved away), luasnip still
        -- remembers that there is a jump position, and doesn't recognize the snippet was filled
        -- manually, or that we left it. This causes <Tab> to jump us to this position (which
        -- could be thousands of lines away), even if we just wanted to indent something.
        mapping = {
          -- Make <Tab> purely handle confirming a selected option, otherwise act like a regular tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.confirm { select = true }
            else
              fallback()
            end
          end, { "i", "s" }),
          -- Unmount <S-Tab> (we now use <C-k> for prev item, and <C-p> for luasnip prev pos)
          ["<S-Tab>"] = cmp.mapping(function(fallback) fallback() end, { "i", "s" }),

          -- <C-n> and <C-p> for navigating snippets
          ["<C-n>"] = cmp.mapping(function()
            if luasnip.jumpable(1) then luasnip.jump(1) end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function()
            if luasnip.jumpable(-1) then luasnip.jump(-1) end
          end, { "i", "s" }),

          -- Have <C-j> also handle starting completion (along with next item selection)
          ["<C-j>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
            else
              cmp.complete()
            end
          end, { "i", "s" }),
        },
      })
    end,
  },
}

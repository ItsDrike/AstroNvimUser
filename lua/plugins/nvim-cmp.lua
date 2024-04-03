return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip_ok, luasnip = pcall(require, "luasnip")
    local copilot_ok, copilot = pcall(require, "copilot.suggestion")

    if not opts.mapping then opts.mapping = {} end

    -- Helper function, checking if there are any words before cursor
    -- (This is copied from AstroNvim source)
    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    -- Only use <Tab> to confirm completions, otherwise act like regular tab
    -- (This disables LuaSnip handling for <Tab>, which overrides tabs if pending snippet is present,
    -- additionally, it disables confirming copilot suggestions with <Tab>. These functionalities were
    -- given their own handling below.)
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end, { "i", "s" })

    -- Unmount <S-Tab> (I prefer using <C-k> for prev item, and <C-p> for luasnip prev pos)
    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback) fallback() end, { "i", "s" })

    -- Use <C-n> to confirm copilot suggestion or to jump to next snippet position
    opts.mapping["<C-n>"] = cmp.mapping(function()
      if copilot_ok and copilot.is_visible() then
        copilot.accept()
      elseif luasnip_ok and luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end, { "i", "s" })

    -- Use <C-p> to jump to previous snippet position
    opts.mapping["<C-p>"] = cmp.mapping(function()
      if luasnip_ok and luasnip.jumpable(-1) then luasnip.jump(-1) end
    end, { "i", "s" })

    -- Have <C-j> handle starting the completion (along with next item selection)
    -- Don't use it to confirm copilot suggestions though
    opts.mapping["<C-j>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
      else
        cmp.complete()
      end
    end, { "i", "s" })

    -- Preconfigured (astrocommunity/astronvim):
    -- * Use <C-c> to dismiss copilot suggestions
    -- * Use <C-l> to confirm next word from copilot suggestion
    -- * Use <C-x> to get the next copilot suggestion
    -- * Use <C-z> to get the prev copilot suggestion
  end,
}

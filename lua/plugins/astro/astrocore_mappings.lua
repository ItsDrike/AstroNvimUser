-- Available mapping modes:
-- i: insert mode
-- n: normal mode
-- x: visual mode
-- s: select mode (like visual, but typing text replaces the selection)
-- v: visual and select mode
-- t: terminal mode (when typing in :terminal buffer)
-- o: operator pending mode (after "d", "y", "c", ...)
-- c: command-line mode (when entering a ":" or "/" command)
-- l: insert, command-line, lang-arg

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        -- Better increment/decrement
        ["+"] = { "<C-a>", desc = "Increment number" },
        ["-"] = { "<C-x>", desc = "Descrement number" },

        -- Select all text
        ["<C-a>"] = { "gg<S-v>G", desc = "Select all" },

        -- Disable search highlights
        ["<Esc>"] = { "<cmd>:noh<CR>", desc = "Disable search highlights" },

        -- Find words
        ["<Leader>/"] = { function() require("snacks").picker.grep() end, desc = "Find words" },

        -- Find files
        ["<Leader><Space>"] = { function() require("snacks").picker.files() end, desc = "Find files" },

        -- Moving between opened buffers
        ["H"] = { "<cmd>bprevious<CR>", desc = "Previous buffer" },
        ["L"] = { "<cmd>bnext<CR>", desc = "Next buffer" },

        -- Open ToggleTerm Terminal
        ["<C-/>"] = { "<cmd>ToggleTerm direction=horizontal<CR>", desc = "ToggleTerm vertical split" },
      },
      v = {
        -- Stay in visual mode when indenting (astronvim also has <Tab>/<S-Tab>)
        ["<"] = { "<gv", desc = "Indent selection" },
        [">"] = { ">gv", desc = "Indent selection" },
      },
      x = {
        -- Better increment/decrement
        ["+"] = { "g<C-a>", desc = "Increment number" },
        ["-"] = { "g<C-x>", desc = "Descrement number" },
      },
      t = {
        -- Close toggleterm
        ["<C-/>"] = { "<cmd>ToggleTerm<CR>", desc = "Toggleterm vertical split" },
      },
    },
  },
}

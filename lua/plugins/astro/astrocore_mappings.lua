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
        -- Use <C-n> for NeoTree toggle (I'm more used to this than the default <leader>e)
        ["<C-n>"] = { "<leader>e", remap = true, desc = "Toggle Explorer" },

        -- Quick word replacing (allowing . for next word replace)
        ["cn"] = { "*``cgn", desc = "Replace word, repeating below" },
        ["cN"] = { "*``cgN", desc = "Replace word, repeating above" },

        -- Better increment/decrement
        ["+"] = { "<C-a>", desc = "Increment number" },
        ["-"] = { "<C-x>", desc = "Descrement number" },

        -- Select all text
        ["<C-a>"] = { "gg<S-v>G", desc = "Select all" },

        -- Disable search highlights
        ["<Esc>"] = { "<cmd>:noh<CR>", desc = "Disable search highlights" },
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
    },
  },
}

local options = {
  opt = {
    wrap = true, -- enable line wrapping
    -- foldexpr = "nvim_treesitter#foldexpr()", -- set Treesitter based folding
    -- foldmethod = "expr",
    linebreak = true, -- linebreak soft wrap at words
    list = true, -- show some invisible characters (tabs...)
    spell = true, -- Enable spellcheck
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_enabled = true, -- enable diagnostics at start
    status_diagnostics_enabled = true, -- enable diagnostics in statusline
    markdown_fenced_languages = { -- Mappings for markdown fenced languages syntax
      "ts=typescript",
      "py=python",
    },
  },
}

-- Disable icons in the UI if in TTY (needs nerd-fonts)
if os.getenv "TERM" == "linux" then
  options.g.icons_enabled = false
  options.g.tty = true
else
  options.g.icons_enabled = true -- Set to false here too if you don't have nerd-fonts
  options.g.tty = false
end

if options.g.tty then
  options.opt.listchars = {
    tab = " ", -- Tab
    trail = "·", -- Trailing spaces
    extends = "⟩", -- Character to show in last column when wrap is off and line continues
    precedes = "⟨", -- Character to show in first column when there is text preceeding the first visible character
    nbsp = "␣", -- Non-breaking space
  }
  options.opt.showbreak = "﬌ " -- String to put at the start of lines that have been wrapped.
else
  options.opt.listchars = {
    tab = "→ ", -- Tab
    trail = "·", -- Trailing spaces
    extends = "›", -- Character to show in last column when wrap is off and line continues
    precedes = "‹", -- Character to show in first column when there is text preceeding the first visible character
    nbsp = " ", -- Non-breaking space TODO: Needs better ASCII symbol
  }
  options.opt.showbreak = "» " -- String to put at the start of lines that have been wrapped.
end

return options

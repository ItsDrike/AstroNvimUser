local options = {
  opt = {
    wrap = true, -- sets vim.opt.wrap
    -- foldexpr = "nvim_treesitter#foldexpr()", -- set Treesitter based folding
    -- foldmethod = "expr",
    linebreak = true, -- linebreak soft wrap at words
    list = true, -- show some invisible characters (tabs...)
    listchars = { tab = " ", trail = "·" }, -- specify what chars to show and with what symbols (extends = "⟩", precedes = "⟨", eol = "﬋", nbsp = "␣")
    -- showbreak = "﬌ ",
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_enabled = true, -- enable diagnostics at start
    status_diagnostics_enabled = true, -- enable diagnostics in statusline
  },
}

-- Disable icons in the UI if in TTY (needs nerd-fonts)
if os.getenv "TERM" == "linux" then
  options.g.icons_enabled = false
else
  options.g.icons_enabled = true -- Set to false here too if you don't have nerd-fonts
end

return options

-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
--
-- The default icons are defined in
-- <https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/_astroui.lua>

-- Default icons
-- (I only keep this here for reference)
local _ = {
  icons = {
    ActiveLSP = "",
    ActiveTS = "",
    ArrowLeft = "",
    ArrowRight = "",
    Bookmarks = "",
    BufferClose = "󰅖",
    DapBreakpoint = "",
    DapBreakpointCondition = "",
    DapBreakpointRejected = "",
    DapLogPoint = ".>",
    DapStopped = "󰁕",
    Debugger = "",
    DefaultFile = "󰈙",
    Diagnostic = "󰒡",
    DiagnosticError = "",
    DiagnosticHint = "󰌵",
    DiagnosticInfo = "󰋼",
    DiagnosticWarn = "",
    Ellipsis = "…",
    Environment = "",
    FileNew = "",
    FileModified = "",
    FileReadOnly = "",
    FoldClosed = "",
    FoldOpened = "",
    FoldSeparator = " ",
    FolderClosed = "",
    FolderEmpty = "",
    FolderOpen = "",
    Git = "󰊢",
    GitAdd = "",
    GitBranch = "",
    GitChange = "",
    GitConflict = "",
    GitDelete = "",
    GitIgnored = "◌",
    GitRenamed = "➜",
    GitSign = "▎",
    GitStaged = "✓",
    GitUnstaged = "✗",
    GitUntracked = "★",
    LSPLoading1 = "",
    LSPLoading2 = "󰀚",
    LSPLoading3 = "",
    MacroRecording = "",
    Package = "󰏖",
    Paste = "󰅌",
    Refresh = "",
    Search = "",
    Selected = "❯",
    Session = "󱂬",
    Sort = "󰒺",
    Spellcheck = "󰓆",
    Tab = "󰓩",
    TabClose = "󰅙",
    Terminal = "",
    Window = "",
    WordFile = "󰈭",
  },
  text_icons = {
    ActiveLSP = "LSP:",
    ArrowLeft = "<",
    ArrowRight = ">",
    BufferClose = "x",
    DapBreakpoint = "B",
    DapBreakpointCondition = "C",
    DapBreakpointRejected = "R",
    DapLogPoint = "L",
    DapStopped = ">",
    DefaultFile = "[F]",
    DiagnosticError = "X",
    DiagnosticHint = "?",
    DiagnosticInfo = "i",
    DiagnosticWarn = "!",
    Ellipsis = "...",
    Environment = "Env:",
    FileModified = "*",
    FileReadOnly = "[lock]",
    FoldClosed = "+",
    FoldOpened = "-",
    FoldSeparator = " ",
    FolderClosed = "[D]",
    FolderEmpty = "[E]",
    FolderOpen = "[O]",
    GitAdd = "[+]",
    GitChange = "[/]",
    GitConflict = "[!]",
    GitDelete = "[-]",
    GitIgnored = "[I]",
    GitRenamed = "[R]",
    GitSign = "|",
    GitStaged = "[S]",
    GitUnstaged = "[U]",
    GitUntracked = "[?]",
    MacroRecording = "Recording:",
    Paste = "[PASTE]",
    Search = "?",
    Selected = "*",
    Spellcheck = "[SPELL]",
    TabClose = "X",
  },
}

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- Icons can be configured throughout the interface
    icons = {
      -- Listchars/Showbreak characters
      CharTab = " ", -- Tabulator key icon
      CharTrail = "·", -- Trailing spaces
      CharNbsp = "␣", -- Non-breaking space
      CharExtends = "⟩",
      CharPreceeds = "⟨",
      CharShowBreak = "»",

      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",

      -- Misc
      TroubleIcon = "",
    },
    text_icons = {
      -- Listchars/Showbreak characters
      CharTab = "→ ", -- Tabulator key icon
      CharTrail = "·", -- Trailing spaces
      CharNbsp = " ", -- Non-breaking space TODO: Needs a better ASCII symbol
      CharExtends = "›",
      CharPreceeds = "‹",
      CharShowBreak = "﬌",
    },
  },
}

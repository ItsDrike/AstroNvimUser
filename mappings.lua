local utils = require "astronvim.utils"
local is_available = utils.is_available

local maps = {
  i = {}, -- insert mode
  n = {}, -- normal mode
  x = {}, -- visual mode
  s = {}, -- select mode (like visual, but typing text replaces the selection)
  v = {}, -- visual and select mode
  t = {}, -- terminal mode (when typing in :terminal buffer)
  o = {}, -- operator pending mode (after "d", "y", "c", ...)
  c = {}, -- command-line mode (when entering a ":" or "/" command)
  l = {}, -- insert, command-line, lang-arg
}

local sections = {
  x = { desc = " Trouble" },
  xl = { desc = " LSP" },
}

if not vim.g.icons_enabled then vim.tbl_map(function(opts) opts.desc = opts.desc:gsub("^.* ", "") end, sections) end

maps.n["<C-t>"] = { "<F7>", desc = "ToggleTerm float", remap = true }
maps.t["<C-t>"] = { "<F7>", desc = "ToggleTerm float", remap = true }

maps.n["<C-n>"] = { "<leader>e", desc = "Toggle Explorer", remap = true }

-- Really useful for debugging highlights
maps.n["<leader>uH"] = { "<cmd>Telescope highlights<cr>", desc = "Highlight groups" }

-- Moving lines around
maps.n["<A-j>"] = { "<cmd>:m .+1<cr>==", desc = "Move current line down" }
maps.n["<A-k>"] = { "<cmd>:m .-2<cr>==", desc = "Move current line up" }
maps.i["<A-j>"] = { "<cmd>:m .+1<cr>==gi", desc = "Move current line down" }
maps.i["<A-k>"] = { "<cmd>:m .-2<cr>==gi", desc = "Move current line up" }
maps.x["<A-j>"] = { "<cmd>:m '>+1<cr>gv=gv'", desc = "Move current line up" }
maps.x["<A-k>"] = { "<cmd>:m '<-2<cr>gv=gv'", desc = "Move current line down" }
maps.x["J"] = { "<cmd>:m '>+1<cr>gv=gv'", desc = "Move current line up" }
maps.x["K"] = { "<cmd>:m '<-2<cr>gv=gv'", desc = "Move current line down" }

-- Delete to void register & paste without overriding copied text
maps.n["<A-d>"] = { '"_d' }
maps.v["<A-d>"] = { '"_d' }
maps.v["<A-p>"] = { '"_dP' }

-- Quick word replacing (allowing . for next word replace)
maps.n["cn"] = { "*``cgn" }
maps.n["cn"] = { "*``cgN" }

-- Stay in indent mode (astro vim also has <Tab>/<S-Tab>)
maps.v["<"] = "<gv"
maps.v[">"] = ">gv"

-- better increment/decrement
maps.n["+"] = { "<C-a>", desc = "Increment number" }
maps.n["-"] = { "<C-x>", desc = "Descrement number" }
maps.x["+"] = { "g<C-a>", desc = "Increment number" }
maps.x["-"] = { "g<C-x>", desc = "Descrement number" }

-- add more text objects for "in" and "around"
for _, char in ipairs { "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
  for _, mode in ipairs { "x", "o" } do
    maps[mode]["i" .. char] =
    { string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char), desc = "between " .. char }
    maps[mode]["a" .. char] =
    { string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char), desc = "around " .. char }
  end
end

--
-- Plugins
--

if is_available "vim-illuminate" then
  maps.n["]]"] = { function() require("illuminate")["goto_next_reference"](false) end, desc = "Next Reference" }
  maps.n["[["] = { function() require("illuminate")["goto_prev_reference"](false) end, desc = "Prev Reference" }
  maps.v["]]"] = maps.n["]]"]
  maps.v["[["] = maps.n["[["]
end

if is_available "nvim-spectre" then
  maps.n["<leader>fR"] = { function() require("spectre").open() end, desc = "Find & Replace in files (Spectre)" }
end

if is_available "trouble.nvim" then
  maps.n["<leader>x"] = sections.x
  maps.n["<leader>xx"] = { "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" }
  maps.n["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" }
  maps.n["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document diagnostics" }
  maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix list" }
  maps.n["<leader>xL"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location list" }
  maps.n["<leader>xt"] = { "<cmd>TroubleToggle telescope<cr>", desc = "Open current telescope results in Trouble" }

  maps.n["<leader>xl"] = sections.xl
  maps.n["<leader>xlr"] = { "<cmd>TroubleToggle lsp_references<cr>", desc = "References list" }
  maps.n["<leader>xld"] = { "<cmd>TroubleToggle lsp_definitions<cr>", desc = "Definitions list" }
  maps.n["<leader>xli"] = { "<cmd>TroubleToggle lsp_implementations<cr>", desc = "Implementations list" }
  maps.n["<leader>xlt"] = { "<cmd>TroubleToggle lsp_type_definitions<cr>", desc = "Type definitions list" }
end

if is_available "todo-comments.nvim" then
  maps.n["]t"] = { function() require("todo-comments").jump_next() end, desc = "Next todo comment" }
  maps.n["[t"] = { function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" }

  maps.n["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find Todos" }

  if maps.n["<leader>x"] ~= nil then
    maps.n["<leader>xt"] = { "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" }
    maps.n["<leader>xT"] = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" }
  end
end

return maps

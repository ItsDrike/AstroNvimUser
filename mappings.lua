local utils = require "astronvim.utils"
local is_available = utils.is_available

local maps = { i = {}, n = {}, v = {}, t = {}, x = {} }

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

return maps

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

return maps

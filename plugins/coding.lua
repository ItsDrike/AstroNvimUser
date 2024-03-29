return {
  -- better text-objects, allowing treesitter based block selections like (vif - select in function)
  {
    "echasnovski/mini.ai",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter-textobjects" }, -- specified in treesitter spec
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)

      -- register all text objects with which-key
      if require("user.utils.plugins").has "which-key.nvim" then
        ---@type table<string, string>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs { n = "Next", l = "Last" } do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end

        require("which-key").register {
          mode = { "o", "x" },
          i = i,
          a = a,
        }
      end
    end,
  },

  {
    "barklan/capslock.nvim",
    dependencies = {
      {
        "heirline.nvim",
        opts = function(_, opts) table.insert(opts, require("capslock").status_string) end,
      },
    },
    event = "BufEnter",
    keys = {
      { "<C-l>", "<Plug>CapsLockToggle", desc = "Toggle CapsLock (soft)", mode = "i" },
    },
    config = true,
  },

  -- { "ziontee113/syntax-tree-surfer" },
  -- { "andymass/vim-matchup" },
}

return {
  {
    "AstroNvim/astrocore",
    opts = {
      -- sqls.nvim removed its legacy on_attach API, but the SQL pack still calls it.
      -- see: https://github.com/AstroNvim/astrocommunity/issues/1794
      autocmds = { sqls_attach = false },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    optional = true,
    opts = function(_, opts)
      opts.handlers = opts.handlers or {}
      local null_ls = require "null-ls"
      local sqlfluff = { extra_args = { "--dialect", "postgres" } }
      opts.handlers.sqlfluff = function()
        null_ls.register(null_ls.builtins.diagnostics.sqlfluff.with(sqlfluff))
        null_ls.register(null_ls.builtins.formatting.sqlfluff.with(sqlfluff))
      end
    end,
  },
}

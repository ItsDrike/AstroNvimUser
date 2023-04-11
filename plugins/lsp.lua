return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "clangd",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "sqls",
        "sumneko_lua",
        "tsserver",
        "yamlls",
      },
    }
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = {

        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.shfmt.with({ args = { "-i", "2" } }),
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.mypy,
      }
      return opts
    end,
  },

  { "lvimuser/lsp-inlayhints.nvim", config = true },
}

return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
      ensure_installed = {
        "clangd",
        "cssls",
        "dockerls",
        "html",
        "jsonls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "sqlls",
        "lua_ls",
        "tsserver",
        "yamlls",
      },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require "null-ls"
      opts.sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.shfmt.with { args = { "-i", "2" } },

        -- Linters
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.mypy,

        -- Extra
        null_ls.builtins.code_actions.shellcheck,
      }
      return opts
    end,
  },

  -- Hanlde LSP inlay hints (such as x: int, where `: int` is an inlay hint)
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "User AstroFile",
    config = true,
  },

  -- Show function argument names and types as you're entering them
  {
    "ray-x/lsp_signature.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = "InsertEnter",
    opts = {
      hint_prefix = vim.g.icons_enabled and "🐼 " or "[S] ",
      hint_enable = true,
      floating_window = false, -- virtual text only, can still use toggle_key to show the floating window
      transparency = 20, -- make the floating window transparent
      toggle_key = "<C-x>", -- toggle signature on/off in insert mode
      doc_lines = 50,
      max_height = 5,
      bind = true,
      handler_opts = {
        border = "rounded",
      },
    },
    config = function(_, opts) require("lsp_signature").on_attach(opts) end,
  },

  -- Custom clangd LSP, with more features than the default one from lspconfig
  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = function()
      return {
        server = require("astronvim.utils.lsp").config "clangd",
        extensions = { autoSetHints = false },
      }
    end,
  },
}

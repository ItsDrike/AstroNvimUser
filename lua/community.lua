-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Languages
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.basedpyright" },
  --{ import = "astrocommunity.pack.python.ty" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.rust" },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ["rust-analyzer"] = {
        -- Make rust-analyzer use its own profile
        -- (This will give rust-analyzer its own folder in target/, allowing `cargo build`
        -- to run without being blocked by rust-analyzer runs. This will increase disk usage)
        cargo = {
          extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
          extraArgs = { "--profile", "rust-analyzer" },
        },
      },
    },
  },

  -- UI
  { import = "astrocommunity.recipes.heirline-nvchad-statusline" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },

  -- LSP
  -- { import = "astrocommunity.lsp.delimited-nvim" }, -- Visually highlight the range of diagnostic
  -- { import = "astrocommunity.lsp.lsp-signature-nvim" }, -- Better function signature hints
  -- { import = "astrocommunity.lsp.lsplinks-nvim" }, -- Support for LSP textDocument/documentLink (opening links with gx)
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" }, -- Support for LSP file operations by integrating with neo-tree
  -- { import = "astrocommunity.syntax.hlargs-nvim" }, -- highlight function argument variables

  -- Other
  { import = "astrocommunity.git.blame-nvim" },
}

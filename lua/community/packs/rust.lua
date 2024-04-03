-- Adds language support for rust
-- Mainly inheriting from astrocommunity import
--
-- Requirements:
-- * Add rust-analyzer, managed by rustup: rustup component add rust-analyzer

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.rust" },
  },

  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              -- Make rust-analyzer use its own profile
              -- (This will give rust-analyzer its own folder in target/, allowing `cargo build`
              -- to run without being blocked by rust-analyzer runs. This will increase disk usage)
              cargo = {
                extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
                extraArgs = { "--profile", "rust-analyzer" },
              },

              -- Use clippy instead of cargo check
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
      },
    },
  },
}

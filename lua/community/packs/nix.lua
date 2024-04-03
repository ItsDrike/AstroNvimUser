-- Adds language support for nix
-- Mainly inheriting from astrocommunity import
--
-- Requirements:
-- * Following needs to be in your PATH:
--   * alejandra
--   * deadnix
--   * statix

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    --{ import = "astrocommunity.pack.nix" },
  },
}

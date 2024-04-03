-- Adds language support for go
-- Mainly inheriting from astrocommunity import
--
-- Requirements:
-- * `go` must be installed in your PATH

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.go" },
  },
}

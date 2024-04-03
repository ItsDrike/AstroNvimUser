-- Adds language support for rust
-- Mainly inheriting from astrocommunity python-ruff import (which itself inherits from python import)
--
-- Requirements:
-- * `python` must be installed in your PATH

---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.python-ruff" },
  },
}

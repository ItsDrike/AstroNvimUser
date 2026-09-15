return {
  {
    "AstroNvim/astrocore",
    opts = {
      -- sqls.nvim removed its legacy on_attach API, but the SQL pack still calls it.
      -- see: https://github.com/AstroNvim/astrocommunity/issues/1794
      autocmds = { sqls_attach = false },
    },
  }
}

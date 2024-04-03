-- Adds vimtex support
-- Mainly inheriting from astrocommunity import
--
-- Requirements:
-- * `zathura` must be installed in your PATH
return {
  {
    "AstroNvim/astrocommunity",

    { import = "astrocommunity.markdown-and-latex.vimtex" },
  },
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",
      }
    end,
  },
}

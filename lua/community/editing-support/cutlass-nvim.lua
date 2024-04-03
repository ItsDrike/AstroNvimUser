-- Adds vimtex support
-- Mainly inheriting from astrocommunity import
--
-- Overrides the keys c,C,s,S,d,D,x,X to delete to void register
-- specifying a custom cut_key which will actually cut (delete+copy)

return {
  {
    "AstroNvim/astrocommunity",

    { import = "astrocommunity.editing-support.cutlass-nvim" },
  },
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "m",
    },
  },
}

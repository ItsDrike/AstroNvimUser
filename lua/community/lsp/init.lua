-- This file contains a list of various astrocommunity imports to be used.
-- These imports do not need any specific settings to them, they are just
-- declared and work out of the box. They also shouldn't require any
-- system dependencies, all necessary tooling should be installed automatically
-- via mason.
--
-- The rest of the packs are defined in individual files for each pack.
-- These are separate as they also make changes to other plugins / add new plugins.
-- A pack might also be defined in a standalone file if it has some system
-- dependency that needs to be mentioned. In this case, such dependencies are listed
-- in a comment at the beginning of the file for that pack.

return {
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.lsp.delimited-nvim" }, -- Visually highlight the range of diagnostic
  { import = "astrocommunity.lsp.garbage-day-nvim" }, -- Stops inactive LSP clients to ree up RAM
  { import = "astrocommunity.lsp.lsp-signature-nvim" }, -- Better function signature hints
  { import = "astrocommunity.lsp.lsplinks-nvim" }, -- Support for LSP textDocument/documentLink (opening links with gx)
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" }, -- Support for LSP file operations by integrating with nvim-tree and neo-tree
}

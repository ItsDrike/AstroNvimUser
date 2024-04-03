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

  --{ import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
}

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

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.just" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.typst" },
  { import = "astrocommunity.pack.yaml" },

  --{ import = "astrocommunity.pack.java" },
  --{ import = "astrocommunity.pack.cs" },
  --{ import = "astrocommunity.pack.tailwindcss" },
}

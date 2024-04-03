-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

--- Search for all directories in community/ and generate a lazy.nvim spec
--- like {{ import = "community.a" }, { import = "community.b" }, ...}
--- This avoid having to specify every directory manually in here, when we
--- know we'll always want to import all of them.
local function generate_community_spec()
  local base_path = vim.fn.stdpath "config" .. "/lua/community"
  local search_result = vim.fn.globpath(base_path, "*", 0, 1)
  local modules = {}

  for _, path in ipairs(search_result) do
    if vim.fn.isdirectory(path) == 1 then
      local module_name = path:match "^.+/(.+)$"
      table.insert(modules, { import = "community." .. module_name })
    end
  end

  return modules
end

return generate_community_spec()

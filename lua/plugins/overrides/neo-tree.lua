---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      -- Use a smaller indent size without padding
      -- (works better when working with projects that do a lot of dir nesting)
      default_component_configs = {
        indent = {
          indent_size = 1,
          padding = 1,
          with_markers = true,
          with_expanders = true,
        },
      },
    },
  },
}

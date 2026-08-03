-- Highlight TODOs that contain assigned users
---@type LazySpec
return {
  "folke/todo-comments.nvim",
  optional = true,
  opts = {
    highlight = {
      pattern = { [[.*<(KEYWORDS)\s*:]], [[.*<(KEYWORDS)\s*\(.*\)\s*:]] },
    },
  },
}

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "floatterm",
    "lspinfo",
    "lir",
    "lsp-installer",
    "null-ls-info",
    "tsplayground",
    "spectre_panel",
    "startuptime",
    "DressingSelect",
    "Jaq",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>Close<CR>", { buffer = event.buf, silent = true })
  end,
  desc = "Close certain filetypes with q",
})

-- Enable spellcheck and line wrapping in text files
vim.api.nvim_create_autocmd({ "FileType", }, {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

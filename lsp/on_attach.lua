return function(client, bufnr)
  local diagnostics_active = true
  vim.keymap.set("n", "<leader>lt", function()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end, { buffer = bufnr, desc = "Toggle diagnostics" })

  if client.server_capabilities.inlayHintProvider then
    local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
    if inlayhints_avail then
      inlayhints.on_attach(client, bufnr)
      vim.keymap.set("n", "<leader>lH", function() inlayhints.toggle() end, { desc = "Toggle inlay hints" })
    end
  end
end

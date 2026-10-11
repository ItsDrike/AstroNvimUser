-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't fit in the normal config
-- locations above can go here

-- Use the OSC 52 provider when running over SSH.
--
-- This makes Neovim emit standard terminal escape sequences that tell the
-- terminal emulator (e.g. kity) to handle a given clipboard interaction
-- (copy/paste).
--
-- Not all terminal emulators support this, but most modern ones do. This makes
-- the clipboard work over SSH because the connecting client's terminal emulator
-- receives the OSC 52 sequence and can store the value in the client's local
-- clipboard.
if vim.env.SSH_CONNECTION or vim.env.SSH_TTY or vim.env.SSH_CLIENT then
  vim.g.clipboard = "osc52"
end

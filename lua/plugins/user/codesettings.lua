---@type LazySpec
return {
  {
    "mrjones2014/codesettings.nvim",
    dependencies = {
      {
        "AstroNvim/astrolsp",
        ---@type AstroLSPOpts
        opts = {
          config = {
            ["*"] = {
              before_init = function(_, config)
                local codesettings = require "codesettings"
                codesettings.with_local_settings(config.name, config)
              end,
            },
            ["rust-analyzer"] = {
              before_init = function(init_params, config)
                local codesettings = require "codesettings"
                codesettings.with_local_settings(config.name, config)
                -- Some settings must be passed at init time, for example rust-analyzer.workspace.discoverConfig
                if config.default_settings and config.default_settings[config.name] then
                  init_params.initializationOptions = config.default_settings[config.name]
                end
              end,
            },
          },
        },
      },
    },
  },
}

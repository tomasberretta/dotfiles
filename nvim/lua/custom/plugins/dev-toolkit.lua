return {
  {
    'Dev-Toolkit',
    dir = vim.fn.stdpath('config') .. '/lua/custom/dev-toolkit',
    name = 'dev-toolkit',
    config = function()
      require('custom.dev-toolkit').setup()
    end,
    keys = {
      -- Text & Content Tools (u = utilities)
      { '<leader>uj', '<cmd>lua require("custom.dev-toolkit.text").json_viewer()<cr>', desc = '[U]tils: [J]SON Viewer' },
      { '<leader>uc', '<cmd>lua require("custom.dev-toolkit.text").case_converter()<cr>', desc = '[U]tils: [C]ase Converter' },
      { '<leader>ud', '<cmd>lua require("custom.dev-toolkit.text").text_diff()<cr>', desc = '[U]tils: Text [D]iff' },
      { '<leader>ut', '<cmd>lua require("custom.dev-toolkit.text").token_counter()<cr>', desc = '[U]tils: [T]oken Counter' },
      { '<leader>um', '<cmd>lua require("custom.dev-toolkit.text").markdown_preview()<cr>', desc = '[U]tils: [M]arkdown Preview' },
      
      -- Encoding & Conversion Tools
      { '<leader>ub', '<cmd>lua require("custom.dev-toolkit.encoding").base64()<cr>', desc = '[U]tils: [B]ase64 Convert' },
      { '<leader>uu', '<cmd>lua require("custom.dev-toolkit.encoding").url_encode()<cr>', desc = '[U]tils: [U]RL Encode' },
      { '<leader>un', '<cmd>lua require("custom.dev-toolkit.encoding").number_base()<cr>', desc = '[U]tils: [N]umber Base Convert' },
      { '<leader>uC', '<cmd>lua require("custom.dev-toolkit.encoding").csv_json()<cr>', desc = '[U]tils: [C]SV/JSON Convert' },
      
      -- Generators & Utilities
      { '<leader>uU', '<cmd>lua require("custom.dev-toolkit.generators").uuid()<cr>', desc = '[U]tils: [U]UID Generate' },
      { '<leader>uq', '<cmd>lua require("custom.dev-toolkit.generators").qr_code()<cr>', desc = '[U]tils: [Q]R Code Generate' },
      { '<leader>uh', '<cmd>lua require("custom.dev-toolkit.generators").hash()<cr>', desc = '[U]tils: [H]ash Generate' },
      { '<leader>ul', '<cmd>lua require("custom.dev-toolkit.generators").lorem()<cr>', desc = '[U]tils: [L]orem Generate' },
      { '<leader>uT', '<cmd>lua require("custom.dev-toolkit.generators").timestamp()<cr>', desc = '[U]tils: [T]imestamp' },
      { '<leader>up', '<cmd>lua require("custom.dev-toolkit.generators").color_palette()<cr>', desc = '[U]tils: Color [P]alette' },
      
      -- Development Tools
      { '<leader>uJ', '<cmd>lua require("custom.dev-toolkit.dev").jwt_decoder()<cr>', desc = '[U]tils: [J]WT Decode' },
      { '<leader>us', '<cmd>lua require("custom.dev-toolkit.dev").sql_format()<cr>', desc = '[U]tils: [S]QL Format' },
      { '<leader>ur', '<cmd>lua require("custom.dev-toolkit.dev").regex_generator()<cr>', desc = '[U]tils: [R]egex Generator' },
      { '<leader>uk', '<cmd>lua require("custom.dev-toolkit.dev").cron_calculator()<cr>', desc = '[U]tils: Cron Cal[k]ulator' },
      
      -- Main menu
      { '<leader>u<space>', '<cmd>lua require("custom.dev-toolkit").menu()<cr>', desc = '[U]tils: Show Menu' },
    },
  },
}
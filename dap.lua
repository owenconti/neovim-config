local dap = require('dap')
require('dapui').setup()

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/Users/owen/development/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}


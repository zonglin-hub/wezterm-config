-- 不同系统启动菜单 --

local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   options.default_prog = { 'nu' }
   options.launch_menu = {

      -- 卸载 PowerShell Core，禁用
      -- { label = 'PowerShell Core', args = { 'pwsh' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt',     args = { 'cmd' } },
      { label = 'Nushell',            args = { 'nu' } },
      { label = 'Ubuntu',             args = { 'ssh', 'zonglin@172.20.115.202', '-p', '22' } },
   }
elseif platform.is_mac then
   options.default_prog = { 'bash' }
   options.launch_menu = {
      { label = 'Bash',    args = { 'bash' } },
      { label = 'Fish',    args = { 'fish' } },
      { label = 'Nushell', args = { 'nu' } },
      { label = 'Zsh',     args = { 'zsh' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'bash' }
   options.launch_menu = {
      { label = 'Bash',    args = { 'bash' } },
      { label = 'Fish',    args = { 'fish' } },
      { label = 'Nushell', args = { 'nu' } },
      { label = 'Zsh',     args = { 'zsh' } },
   }
end

return options

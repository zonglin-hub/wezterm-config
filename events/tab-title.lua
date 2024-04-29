local wezterm = require('wezterm')

local color = {
   default = {
      bg = "#85248C",
      fg = "#0F2536",
   },
   is_active = {
      bg = "#46A4A6",
      fg = "#0F2536",
   },

   hover = {
      bg = "#B531BF",
      fg = "#0F2536",
   },
}

local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%$', '')
end

local _set_title = function(process_name, base_title, max_width, inset)
   local title
   inset = inset or 6

   -- 自定义窗口图标
   if process_name == "nu" then
      local linux_icon = utf8.char(0xebc6) .. ' '
      title = linux_icon .. process_name .. ' '
   elseif process_name == "bash" then
      local bash_icon = utf8.char(0xebca) .. ' '
      title = bash_icon .. process_name .. ' '
   elseif process_name == "cmd" then
      local cmd_icon = utf8.char(0xebc4) .. ' '
      title = cmd_icon .. process_name .. ' '
   elseif process_name == "powershell" then
      local pwsh_icon = utf8.char(0xf0a0a)
      title = pwsh_icon .. process_name .. ' '
   elseif process_name == "top" then
      local top_icon = utf8.char(0xf00d1)
      title = top_icon .. " " .. process_name .. ' '
   else
      title = base_title
   end

   return title
end

local _check_if_admin = function(p)
   if p:match('^root: ') then
      return true
   end

   return false
end

local M = {}
local cells = {}

---@param fg string
---@param bg string
---@param attribute table
---@param text string
local _push = function(bg, fg, attribute, text)
   table.insert(cells, { Background = { Color = bg } })
   table.insert(cells, { Foreground = { Color = fg } })
   table.insert(cells, { Attribute = attribute })
   table.insert(cells, { Text = text })
end

M.setup = function()
   wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
      cells = {}

      local bg
      local fg
      local process_name = _set_process_name(tab.active_pane.foreground_process_name)
      local is_admin = _check_if_admin(tab.active_pane.title)
      local title = _set_title(process_name, tab.active_pane.title, max_width, (is_admin and 8))

      if tab.is_active then
         bg = color.is_active.bg
         fg = color.is_active.fg
      elseif hover then
         bg = color.hover.bg
         fg = color.hover.fg
      else
         bg = color.default.bg
         fg = color.default.fg
      end

      local has_unseen_output = false
      for _, pane in ipairs(tab.panes) do
         if pane.has_unseen_output then
            has_unseen_output = true
            break
         end
      end

      -- 左半圆
      local glyph_semi_circle_left = utf8.char(0xe0b6)
      _push(fg, bg, { Intensity = 'Bold' }, glyph_semi_circle_left)

      -- 管理员图标
      local glyph_admin = utf8.char(0xf0780)
      if is_admin then
         _push(bg, fg, { Intensity = 'Bold' }, ' ' .. glyph_admin)
      end

      -- 标题
      _push(bg, fg, { Intensity = 'Bold' }, ' ' .. title)

      -- 看不见的输出警报
      local glyph_circle = utf8.char(0xf111)
      if has_unseen_output then
         _push(bg, '#FFA066', { Intensity = 'Bold' }, ' ' .. glyph_circle)
      end

      -- 右填充
      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- 右半圆
      local glyph_semi_circle_right = utf8.char(0xe0b4)
      _push(fg, bg, { Intensity = 'Bold' }, glyph_semi_circle_right)

      return cells
   end)
end

return M

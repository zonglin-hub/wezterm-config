-- 外观设置 --

local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local color = require('colors.custom')

return {
   animation_fps = 60,
   max_fps = 60,

   -- ref: https://wezfurlong.org/wezterm/config/lua/config/front_end.html?h=front_end
   front_end = 'OpenGL',
   webgpu_power_preference = 'HighPerformance',
   webgpu_preferred_adapter = gpu_adapters:pick(),

   -- 主题
   colors = color,

   -- 背景
   -- ref: https://wezfurlong.org/wezterm/config/lua/config/background.html?h=background
   background = {
      {
         source = { File = wezterm.GLOBAL.background },
      },
      {
         source = { Color = color.background },
         height = '100%',
         width = '100%',
         -- 不透明
         opacity = 0.96,
      },
   },

   -- 滚动条
   enable_scroll_bar = true,
   min_scroll_bar_height = "3cell",
   -- colors = {
   --    scrollbar_thumb = '#174040',
   -- },


   -- 光标
   default_cursor_style = "BlinkingBlock",
   cursor_blink_ease_in = "Constant",
   cursor_blink_ease_out = "Constant",
   cursor_blink_rate = 700,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = true,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = true,
   switch_to_last_active_tab_when_closing_tab = true,

   -- 窗口
   adjust_window_size_when_changing_font_size = false,
   window_decorations = "INTEGRATED_BUTTONS|RESIZE",
   integrated_title_button_style = "Windows",
   integrated_title_button_color = "auto",
   integrated_title_button_alignment = "Right",
   initial_cols = 120,
   initial_rows = 35,
   window_padding = {
      left = 5,
      right = 10,
      top = 12,
      bottom = 7,
   },
   window_close_confirmation = 'AlwaysPrompt',
   window_frame = {
      active_titlebar_bg = '#0F2536',
      inactive_titlebar_bg = '#0F2536',
   },
   inactive_pane_hsb = {
      saturation = 0.9,
      brightness = 0.65,
   },
}

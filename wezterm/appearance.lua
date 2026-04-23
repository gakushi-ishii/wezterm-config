-- 外観設定モジュール
-- カラースキーム、フォント、ウィンドウの見た目を管理

local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
  -- カラースキーム
  config.color_scheme = 'Catppuccin Mocha'

  -- フォント設定
  config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' },
    'Noto Sans CJK JP',
    'Noto Color Emoji',
  }
  config.font_size = 13.0
  config.line_height = 1.1

  -- リガチャ有効化
  config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

  -- ウィンドウ設定
  config.initial_cols = 140
  config.initial_rows = 35
  config.window_decorations = 'RESIZE'
  config.window_background_opacity = 0.95
  config.window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  }

  -- タブバー
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = true
  config.tab_bar_at_bottom = false
  config.tab_max_width = 28

  -- カーソル
  config.default_cursor_style = 'SteadyBar'
  config.cursor_blink_rate = 0

  -- 非アクティブペインの見た目
  config.inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.7,
  }

  -- GPU レンダリング
  config.front_end = 'WebGpu'
  config.max_fps = 120
  config.animation_fps = 30
end

return module

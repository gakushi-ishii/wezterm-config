-- WezTerm メイン設定ファイル
-- 各モジュールから設定を読み込む

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- モジュール読み込み
local appearance = require 'appearance'
local keys = require 'keys'
local launch = require 'launch'

-- 各モジュールの設定を適用
appearance.apply_to_config(config)
keys.apply_to_config(config)
launch.apply_to_config(config)

-- 日本語入力サポート（必須）
config.use_ime = true

-- スクロールバック行数
config.scrollback_lines = 10000

-- ベル音を無効化
config.audible_bell = 'Disabled'

-- フォントサイズ変更時にウィンドウサイズを変えない
config.adjust_window_size_when_changing_font_size = false

return config

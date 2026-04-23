-- キーバインド設定モジュール
-- Leader キー、ペイン操作、タブ操作のキーバインドを管理

local wezterm = require 'wezterm'
local act = wezterm.action
local module = {}

function module.apply_to_config(config)
  -- Leader キー (CTRL+A)、tmux 風
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

  config.keys = {
    -- ペイン分割
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

    -- ペイン間移動
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },

    -- ペインサイズ調整モード
    { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },

    -- ペインを閉じる
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

    -- タブ操作
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },

    -- CTRL-A を実際に送信
    { key = 'a', mods = 'LEADER|CTRL', action = act.SendKey { key = 'a', mods = 'CTRL' } },

    -- コピーモード
    { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },

    -- Quick Select
    { key = 'Space', mods = 'CTRL|SHIFT', action = act.QuickSelect },

    -- ランチャー
    { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|DOMAINS|LAUNCH_MENU_ITEMS' } },

    -- フォントサイズ
    { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
    { key = '_', mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  }

  -- Key Tables（モーダルキーバインド）
  config.key_tables = {
    resize_pane = {
      { key = 'h', action = act.AdjustPaneSize { 'Left', 2 } },
      { key = 'l', action = act.AdjustPaneSize { 'Right', 2 } },
      { key = 'k', action = act.AdjustPaneSize { 'Up', 2 } },
      { key = 'j', action = act.AdjustPaneSize { 'Down', 2 } },
      { key = 'Escape', action = 'PopKeyTable' },
    },
  }

  -- マウスバインド
  config.mouse_bindings = {
    -- CTRL + クリックでリンクを開く
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.Nop,
    },
  }
end

return module

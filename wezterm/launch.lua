-- 起動設定モジュール
-- WSL 起動、tmux 自動起動、ランチャーメニューを管理

local module = {}

function module.apply_to_config(config)
  -- WSL (Ubuntu) + tmux 自動起動
  -- 既存セッションがあればアタッチ、なければ 3 ペインレイアウトで新規作成
  -- レイアウト:
  --   ┌──────┬──────┐
  --   │  上左 │  上右 │
  --   ├──────┴──────┤
  --   │     下      │
  --   └─────────────┘
  config.default_prog = {
    'wsl.exe', '--distribution', 'Ubuntu', '--cd', '~/workspace', '--',
    'bash', '-lc',
    'tmux has-session -t main 2>/dev/null && tmux attach-session -t main || '
      .. '(tmux new-session -d -s main'
      .. ' && tmux split-window -v -t main:0.0'
      .. ' && tmux split-window -h -t main:0.0'
      .. ' && tmux select-pane -t main:0.0'
      .. ' && tmux attach-session -t main);'
      .. ' exec bash -l'
  }

  -- デフォルト作業ディレクトリ
  -- config.default_cwd = 'C:\\Users\\<ユーザー名>\\projects'

  -- ランチャーメニュー
  config.launch_menu = {
    {
      label = 'Ubuntu (WSL)',
      args = { 'wsl.exe', '--distribution', 'Ubuntu' },
    },
    {
      label = 'Ubuntu + tmux',
      args = {
        'wsl.exe', '--distribution', 'Ubuntu', '--',
        'bash', '-lc', 'tmux new-session -A -s main',
      },
    },
    {
      label = 'PowerShell',
      args = { 'powershell.exe', '-NoLogo' },
    },
    {
      label = 'Command Prompt',
      args = { 'cmd.exe' },
    },
  }
end

return module

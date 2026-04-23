-- 起動設定モジュール
-- WSL 起動、tmux 自動起動、ランチャーメニューを管理

local module = {}

function module.apply_to_config(config)
  -- WSL (Ubuntu) を自動起動
  -- tmux も自動起動する場合は下のコメントを切り替える

  -- パターン A: WSL のみ起動
  config.default_prog = { 'wsl.exe', '--distribution', 'Ubuntu' }

  -- パターン B: WSL + tmux 自動起動（セッション名: main）
  -- 既存セッションがあればアタッチ、なければ新規作成
  -- config.default_prog = {
  --   'wsl.exe', '--distribution', 'Ubuntu', '--',
  --   'bash', '-lc', 'tmux new-session -A -s main'
  -- }

  -- パターン C: WSL + カスタム tmux スクリプト
  -- ペインレイアウトを細かく制御したい場合
  -- config.default_prog = {
  --   'wsl.exe', '--distribution', 'Ubuntu', '--',
  --   'bash', '-lc', '$HOME/.local/bin/start-tmux.sh'
  -- }

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

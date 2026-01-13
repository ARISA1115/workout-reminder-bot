# squats-bot

スクワットチャレンジのリマインダーをSlackに自動送信するボットです。

## 概要

平日の決まった時間にSlackにスクワットチャレンジのメッセージを自動送信します。GitHub Actionsまたはローカルのcronで実行できます。

## 機能

- 平日の複数の時間帯に自動でSlackに通知
- 10回のスクワットをリマインド
- GitHub Actionsまたはローカルcronで実行可能

## セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd squats-bot
```

### 2. 環境変数の設定

`.env`ファイルを作成し、SlackのWebhook URLを設定します：

```bash
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

### 3. 実行方法

#### GitHub Actionsで実行する場合

1. GitHubリポジトリのSettings > Secrets and variables > Actionsに移動
2. `SLACK_WEBHOOK_URL`という名前でシークレットを追加
3. ワークフローが自動的にスケジュール実行されます

手動実行する場合は、GitHub Actionsのワークフローから「Run workflow」を選択してください。

#### ローカルでcron実行する場合

```bash
# crontabに設定を追加
crontab crontab.txt

# または、既存のcrontabに追加
crontab -e
```

## 実行スケジュール

### GitHub Actions（UTC時間）

- 平日 00:00, 03:00, 06:00, 09:00（JST 09:00, 12:00, 15:00, 18:00）
- 平日 00:45, 03:45, 06:45（JST 09:45, 12:45, 15:45）
- 平日 01:30, 04:30, 07:30（JST 10:30, 13:30, 16:30）
- 平日 02:15, 05:15, 08:15（JST 11:15, 14:15, 17:15）

### ローカルcron（JST時間）

- 平日 09:00, 12:00, 15:00, 18:00
- 平日 09:45, 12:45, 15:45
- 平日 10:30, 13:30, 16:30
- 平日 11:15, 14:15, 17:15

## ファイル構成

```
squats-bot/
├── .github/
│   └── workflows/
│       └── suquats.yaml    # GitHub Actionsワークフロー
├── .gitignore              # Git除外設定
├── .env                    # 環境変数（.gitignoreに含まれています）
├── crontab.txt            # ローカルcron設定
├── post_squats.sh         # Slack送信スクリプト
└── README.md              # このファイル
```

## 手動実行

```bash
# スクリプトに実行権限を付与（初回のみ）
chmod +x post_squats.sh

# 手動実行
./post_squats.sh
```

## 注意事項

- `.env`ファイルには機密情報が含まれるため、Gitにコミットしないでください
- ログファイル（`cron.log`）も`.gitignore`に含まれています

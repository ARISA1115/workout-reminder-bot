# squats-bot

スクワット & ランジチャレンジのリマインダーをSlackに自動送信するボットです。

## 概要

平日の決まった時間にSlackにスクワット & ランジチャレンジのメッセージを自動送信します。GitHub Actionsで実行されます。

## 機能

- 平日の1時間ごと（9:00-18:00）に自動でSlackに通知
- スクワット10回とランジ10回をリマインド（通常）
- 10%の確率でスクワット30回とランジ30回の特別メッセージを送信
- GitHub Actionsで自動実行

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

1. GitHubリポジトリのSettings > Secrets and variables > Actionsに移動
2. `SLACK_WEBHOOK_URL`という名前でシークレットを追加
3. ワークフローが自動的にスケジュール実行されます

手動実行する場合は、GitHub Actionsのワークフローから「Run workflow」を選択してください。

## 実行スケジュール

### GitHub Actions

**平日（月〜金）の1時間ごと：**
- **JST 09:00, 10:00, 11:00, 12:00, 13:00, 14:00, 15:00, 16:00, 17:00, 18:00**
- **UTC 00:00, 01:00, 02:00, 03:00, 04:00, 05:00, 06:00, 07:00, 08:00, 09:00**

1日10回の通知が送信されます。

## ファイル構成

```
squats-bot/
├── .github/
│   └── workflows/
│       └── suquats.yaml    # GitHub Actionsワークフロー
├── .gitignore              # Git除外設定
├── .env                    # 環境変数（.gitignoreに含まれています）
├── crontab.txt            # 参考用のローカルcron設定（現在は未使用）
├── post_squats.sh         # 参考用のSlack送信スクリプト（現在は未使用）
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
- **GitHub Actionsのcronスケジュールには遅延が発生する可能性があります**（最大5分程度）
  - 指定時刻（例：10:00）から数分遅れて通知が届く場合があります
  - これはGitHub Actionsの制限であり、完全に正確な時刻実行は保証されません
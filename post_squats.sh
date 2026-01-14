#!/usr/bin/env bash
set -euo pipefail

# このスクリプトと同じディレクトリに移動（cron対策）
cd "$(dirname "$0")"

# cronはシェル設定を読まないので、.env から環境変数を読み込む
if [ -f ".env" ]; then
  set -a
  # shellcheck disable=SC1091
  source ".env"
  set +a
fi

: "${SLACK_WEBHOOK_URL:?SLACK_WEBHOOK_URL is not set}"

TIMESTAMP=$(TZ=Asia/Tokyo date '+%Y-%m-%d %H:%M:%S JST')
payload=$(cat <<EOF
{
  "text": "🔥 Squat Challenge",
  "blocks": [
    {
      "type": "section",
      "text": {
        "type": "mrkdwn",
        "text": "🔥 *Squat Challenge*\n\n10 reps"
      }
    },
    {
      "type": "context",
      "elements": [
        {
          "type": "mrkdwn",
          "text": "⏰ ${TIMESTAMP}"
        }
      ]
    }
  ]
}
EOF
)

curl -sS -X POST \
  -H 'Content-type: application/json' \
  --data "${payload}" \
  "${SLACK_WEBHOOK_URL}" >/dev/null

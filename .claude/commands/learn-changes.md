# learn-changes

## 概要

ローカルブランチ間の差分を分析し、今後の開発に必要な変更内容を把握する

## 実行手順

### 1. 現在の状態確認

```bash
# 現在のブランチを確認
git branch --show-current

# 未コミットの変更を確認
git status --short
```

### 2. ベースブランチの選択

```bash
# ローカルブランチ一覧を取得（現在のブランチを除く）
git branch | grep -v '^\*' | sed 's/^  //'
```

#### ローカルブランチの存在確認

##### 他のローカルブランチが存在する場合

1. 番号付きリストでベースブランチを出力してください
1. ユーザーが番号を選択したら、そのブランチをベースとして使用してください
1. 無効な番号が入力された場合は「無効な番号です。もう一度番号を入力してください」と再入力を促してください

##### ローカルブランチが存在しない場合

- 「比較可能なブランチがありません」と出力して処理を終了してください

```text
════════════════════════════════════════
🔀 ベースブランチの選択
════════════════════════════════════════

1. branch-name-1
2. branch-name-2
3. branch-name-3

────────────────────────────────────────

▶ 選択してください
```

### 3. 差分の取得と分析

#### 3.1 差分の取得

選択されたベースブランチとの差分を取得してください

```bash
# 差分の統計情報を取得
git diff ${selected_branch}...HEAD --stat

# 変更されたファイル一覧を取得
git diff ${selected_branch}...HEAD --name-status

# 未コミットの変更を確認
git diff --staged
git diff

# 実際の差分内容を取得して分析
git diff ${selected_branch}...HEAD
```

- 変更がない場合
  - 「変更内容がありません」を出力し、処理を終了してください

#### 3.2 変更内容の分析

収集した情報をもとに、以下を理解してください

- 追加/変更/削除された機能
- 変更の主な目的
- 技術的な実装方法
- 影響範囲

### 4. 変更要約の生成

#### 出力ルール

- テンプレートの内容のみを出力する
- テキスト形式で出力する（```text```ブロックで囲む）
- テンプレート以外の説明や補足は追加しない
- `{{! ... }}` で囲まれた例文は出力しない（内部参照用）
- `[...]` のプレースホルダはAIが適切な内容を生成して置き換える
- 変更を機能単位や関連性でグループ化する
- 簡潔で分かりやすい表現を使用する

#### 出力テンプレート

```text
════════════════════════════════════════
📋 変更要約
════════════════════════════════════════

🏷️ [変更カテゴリ]

◆ [具体的な変更内容]
  • [関連ファイルパス]
  • [関連ファイルパス]

◆ [具体的な変更内容]
  • [関連ファイルパス]

────────────────────────────────────────

🏷️ [変更カテゴリ]

◆ [具体的な変更内容]
  • [関連ファイルパス]

◆ [具体的な変更内容]
  • [関連ファイルパス]
```

#### 出力例

```text
════════════════════════════════════════
📋 変更要約
════════════════════════════════════════

🏷️ [機能追加]

◆ usersテーブルにphoneカラムを追加
  • db/schema.rb
  • db/migrate/20240101_add_phone_to_users.rb

◆ Userモデルにphone属性を追加
  • app/models/user.rb

◆ SMSによる認証コード送信機能を実装
  • app/services/sms_service.rb
  • app/services/twilio_client.rb
  • config/credentials.yml

◆ 電話番号でのログインAPIエンドポイントを作成
  • app/controllers/api/auth_controller.rb
  • config/routes.rb

────────────────────────────────────────

🏷️ [機能改善]

◆ メール再送機能を実装
  • app/controllers/password_resets_controller.rb
  • app/mailers/user_mailer.rb

◆ レート制限を追加（1分間に1回まで）
  • app/models/password_reset_request.rb
  • config/initializers/rate_limit.rb

◆ 再送時のエラーメッセージを改善
  • config/locales/ja.yml

────────────────────────────────────────

🏷️ [リファクタリング]

◆ 全エンドポイントで{success, data, message}形式に統一
  • app/controllers/application_controller.rb
  • app/controllers/concerns/api_response.rb

◆ エラー時のHTTPステータスコードを適切に設定
  • app/controllers/concerns/error_handler.rb

◆ レスポンスのバリデーションを追加
  • spec/support/api_schema_matcher.rb
  • spec/requests/**/*_spec.rb

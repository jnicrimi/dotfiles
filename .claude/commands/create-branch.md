# create-branch

## 概要

以下の指示に従って、対話的にGitブランチを作成してください。

## ブランチ名規則

### 使用可能なprefix

- feature: 新機能
- fix: バグ修正
- refactor: リファクタリング
- docs: ドキュメント
- chore: 雑務・メンテナンス

### 命名規則

- ブランチ名は必ず `prefix/descriptive-branch-name` の形式
- 単語はハイフン区切り
- 小文字のみ使用
- **50文字以内を目安にし、可読性を保つ**
- **変更対象を必ず含める**
  - ✅ 良い例: `fix/auth-service-timeout`, `chore/eslint-config-update`
  - ❌ 悪い例: `fix/timeout-issue`, `chore/update-config`
- 対象となるモジュール、サービス、ツール、ファイル名などを明示する

## 実行手順

### 1. 変更内容と対象の分析

- `git diff --staged` でステージされた変更を確認してください
- `git diff` でステージされていない変更も確認してください
- 変更がない場合は、会話履歴から作業内容を推測してください
- 推測の場合は「※ 会話履歴から推測」と明記してください
- **重要**: 変更対象（モジュール、機能、ツール、ファイル、サービスなど）を必ず特定してください

### 2. ブランチ名候補の提示

変更内容に応じて適切な数のブランチ名候補を提示してください（候補は詳細度や表現を変えて差別化）：

**重要**: すべてのブランチ名に必ず変更対象を含めてください

```text
分析結果：

[ステージされた変更、未ステージの変更、または会話履歴からの推測内容]

おすすめのブランチ名：

1. prefix/branch-name-here
   理由: [選定理由]

2. prefix/another-branch
   理由: [選定理由]

... (必要に応じて追加)

n. prefix/nth-option
   理由: [選定理由]

選択してください:
```

※ 番号が若いほど推奨度が高くなっています

#### 推奨候補数

変更内容の複雑さに応じて、2〜6個程度の候補を提示することを推奨します。

#### 例

**新機能の場合:**

```text
1. feature/user-authentication-system
   理由: ユーザー認証という対象が明確で簡潔

2. feature/add-oauth-login-module
   理由: OAuth loginモジュールという対象を具体的に表現
```

**バグ修正の場合:**

```text
1. fix/auth-service-error-handling
   理由: 認証サービスのエラー処理という対象が明確

2. fix/user-validation-logic
   理由: ユーザー検証ロジックという対象を技術的に表現
```

**リファクタリングの場合:**

```text
1. refactor/auth-module-structure
   理由: 認証モジュールという対象が明確で簡潔

2. refactor/consolidate-user-auth-logic
   理由: ユーザー認証ロジックという対象と目的を明示
```

**ドキュメントの場合:**

```text
1. docs/update-project-readme
   理由: プロジェクトREADMEという対象が明確

2. docs/add-api-documentation
   理由: 追加内容を具体的に表現

3. docs/improve-docker-setup-guide
   理由: Dockerセットアップガイドという対象を明示
```

**雑務・メンテナンスの場合:**

```text
1. chore/update-npm-dependencies
   理由: npmの依存関係という対象を明確に表現

2. chore/upgrade-nodejs-runtime
   理由: Node.jsランタイムという対象を具体的に明示

3. chore/claude-settings-optimization
   理由: Claude設定という対象を明確に表現
```

※ 各例では変更内容の複雑さに応じて、2〜6個程度の候補を提示しています

### 3. ブランチ作成と切り替え

- ユーザーが番号を選択したら、そのブランチを作成して切り替えてください
- 候補にない番号が入力された場合は「無効な番号です。もう一度番号を入力してください」と再入力を促してください
- ブランチ名の妥当性を `git check-ref-format` で検証してください
- 選択されたブランチ名が既に存在する場合は「ブランチ '[ブランチ名]' は既に存在します。別の番号を選択してください」と再入力を促してください

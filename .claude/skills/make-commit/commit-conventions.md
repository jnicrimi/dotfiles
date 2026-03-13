# Commit Conventions

## Commit Type

| type | 説明 |
| --- | --- |
| feat | 新機能 |
| fix | バグ修正 |
| refactor | リファクタリング（バグ修正でも機能追加でもないコード変更） |
| docs | ドキュメント |
| test | テスト |
| style | スタイル（コードの意味に影響しない変更） |
| build | ビルド（ビルドシステムや外部依存関係に影響する変更） |
| ci | CI（CI設定ファイルやスクリプトの変更） |
| perf | パフォーマンス（パフォーマンスを向上させるコード変更） |
| chore | 雑務（srcやtestファイルを変更しないその他の変更） |

## Commit Message Format

| 項目 | ルール | 例 |
| --- | --- | --- |
| 基本形式 | `type: description` | `feat: add user authentication` |
| type | 常に英語 | `feat`, `fix`, `docs` |
| description（英語） | 現在形・命令形で記述 | `add` (not `added` nor `adds`) |
| description（日本語） | - | `feat: ユーザー認証機能を追加` |
| 文字数制限 | 1行目は72文字以内 | - |

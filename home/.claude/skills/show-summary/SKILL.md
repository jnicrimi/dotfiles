---
name: show-summary
description: ローカルブランチ間の差分を分析し、変更内容を要約する
allowed-tools: Bash, Read, Grep, Glob
disable-model-invocation: true
---

# show-summary

## Context

- Current branch: !`git branch --show-current`
- Branches: !`git branch --format='%(refname:short)'`

## 概要

ローカルブランチ間の差分を分析し、変更内容を要約する。

## 実行手順

### 1. ベースブランチの選択

Contextセクションを確認。Branchesからカレントブランチを除外したリストを表示。

#### 比較可能なブランチが存在しない場合

「比較可能なブランチがありません。」と出力して処理を終了。

#### 比較可能なブランチが存在する場合

```text
🔀 ベースブランチの選択
────────────────────────────────────────
1. branch-name-1
2. branch-name-2
3. branch-name-3

(1-3):
```

ユーザーが番号を選択したら以下を実行。

- 有効な番号が選択された場合
  - 選択されたベースブランチを記録
- 無効な番号が選択された場合
  - 「無効な番号です。もう一度番号を選択してください。」と再入力を促す

### 2. 差分の取得と分析

#### 2.1 差分の取得

選択されたベースブランチとの差分を取得。

```bash
git diff ${selected_branch}...HEAD --stat
git diff ${selected_branch}...HEAD --name-status
git diff ${selected_branch}...HEAD --ignore-all-space --ignore-blank-lines
```

- 変更がない場合
  - 「変更内容がありません」を出力し、処理を終了

#### 2.2 差分の分析

収集した差分を整理して、以下の項目に分類。

- 追加された機能
- 変更された機能
- 削除された機能

### 3. 変更要約の出力

変更内容を [template.md](./template.md) に従ってまとめる。

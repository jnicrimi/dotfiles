---
name: write-doc
description: セッションでまとまった内容を技術資料としてマークダウンに書き出す
allowed-tools: Bash, Read, Grep, Glob, Write
disable-model-invocation: true
---

# write-doc

## Context

- 出力先ルート: !`git rev-parse --show-toplevel`
- 本日の日付: !`date +%Y-%m-%d`

## 概要

現在のセッションで議論・調査してまとまった内容を、技術資料としてマークダウンファイルに書き出す。資料は AI に読ませることを前提とし、frontmatter を付与する。

## 執筆ルール

[conventions.md](./conventions.md) を参照

## 実行手順

### 1. 資料化対象の確認

セッション内のどの内容を資料化するかをユーザーに確認する。Claude が対象範囲を要約して提示し、ズレがないかを擦り合わせる。

その上で、以下の項目を対話で確定する。

- title（資料タイトル。英語）
- tags（関連するキーワードの配列）
- ファイル名（英語。title に対応させた kebab-case を基本とする）

```text
📝 資料化対象の確認
────────────────────────────────────────
対象範囲: [セッション内容の要約]

title: [提案するタイトル]
tags: [提案するタグ]
ファイル名: [提案するファイル名].md

この内容で進めますか？
```

### 2. 本文の生成

[conventions.md](./conventions.md) の執筆ルールに従って、資料の構成と本文を作成する。

### 3. frontmatter の付与

本文の先頭に以下の frontmatter を付与する。

- title: 確定したタイトル
- tags: 確定したタグ（ブロック形式）
- updated: Context セクションの本日の日付

### 4. ファイル出力

Context セクションの出力先ルート直下に「[ファイル名].md」として書き出す。

### 5. 完了報告

出力したファイルのパスを提示する。

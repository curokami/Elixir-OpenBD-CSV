# OpenBD Book Search

## 概要

**OpenBD Book Search** は、書籍のISBNコードを入力するだけで、その書誌情報（タイトル、著者、出版社、価格など）を簡単に検索できるWebアプリケーションです。このアプリは、出版業界関係者、書店員、図書館員、編集者など、日常的に書籍情報を確認する必要がある方々のために開発されました。

本アプリは **OpenBD API** を利用しており、常に最新の書誌情報を取得できます。余計な操作は不要で、直感的に使えるシンプルなインターフェースが特徴です。

## 主な機能

- 📚 **ISBNコード検索**：13桁のISBNを入力するだけで書誌情報を取得
- 🔍 **書誌情報の表示**：タイトル、著者、出版社、出版日、価格などをわかりやすく表示
- ⚡ **リアルタイム更新**：検索結果は即座に表示、素早い情報取得が可能

## 使い方

1. **ISBNコードを入力**
   - ホーム画面の検索フォームに13桁のISBNコードを入力します。
2. **検索ボタンをクリック**
   - 「検索」ボタンをクリックすると、OpenBD APIを通じて書誌情報が取得されます。
3. **結果の確認**
   - タイトル、著者、出版社、価格などの情報が表示されます。

## インストールと起動方法

### 1. 前提条件

- **Elixir**（バージョン1.14以上）
- **Erlang/OTP**（バージョン26以上）
- **PostgreSQL**（データベースとして使用）
- **Git**（コードのクローンに使用）

### 2. ダウンロード

```bash
# GitHubからプロジェクトをクローン
$ git clone https://github.com/curokami/openbd-booksearch.git

# プロジェクトディレクトリに移動
$ cd openbd-booksearch
```

### 3. 依存関係のインストール

```bash
# 必要なElixirパッケージをインストール
$ mix deps.get

# JavaScriptとCSSの依存関係をインストール
$ cd assets && npm install && cd ..
```

### 4. データベースのセットアップ

```bash
# データベースの作成とマイグレーション実行
$ mix ecto.create
$ mix ecto.migrate
```

### 5. サーバーの起動

```bash
# 開発用サーバーを起動
$ mix phx.server

# またはIExシェルと共に起動
$ iex -S mix phx.server
```

起動後、ブラウザで以下のURLにアクセスしてください：

```
http://localhost:4000
```

### 6. デバッグ用コマンド（JSON表示）

ISBN検索時に取得したJSONデータを確認するには、以下のように `iex` シェルで実行します：

```bash
$ iex -S mix

# 書誌情報を取得し、JSON形式で表示
iex> Booksearch.Getbookdata.request_shoshidata("9784065350157")
```

取得したJSONがデバッグ用にコンソールへ出力されます。

---

## ライセンス

このプロジェクトは [MIT License](LICENSE) のもとで公開されています。

## 貢献

バグ報告や機能提案などのコントリビューションは大歓迎です！GitHubでIssueを作成するか、プルリクエストをお送りください。

## お問い合わせ

- 開発者: **curokami**
- GitHub: [https://github.com/curokami](https://github.com/curokami)

出版業界の皆さまが、日々の業務で役立つツールとしてお使いいただけることを願っています。


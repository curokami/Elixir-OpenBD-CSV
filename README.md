# Elixir-OpenBD-CSV


## 概要

**Elixir-OpenBD-CSV** は、ISBNリストをもとに [OpenBD API](https://openbd.jp/) から書籍データを取得し、CSVファイルとして保存するElixirモジュールです。書籍のタイトル、著者、出版社、出版日、税込価格、税抜価格などの情報を簡単に取得できます。

## 主な機能

- ISBNリストからOpenBD APIを使用して書籍情報を取得
- 書籍データをCSV形式で保存
- 税込価格と税抜価格の自動計算（日本の標準消費税率 10% を適用）
- APIのリクエスト制限に対応したレートリミット（2秒間隔）

## 使用方法

### 前提条件
- Elixir がインストールされていること
- 依存関係として `HTTPoison` と `Jason` が必要

### インストール

1. リポジトリをクローンします。
   ```bash
   git clone git@github.com:curokami/Elixir-OpenBD-CSV.git
   cd Elixir-OpenBD-CSV
   ```

2. 依存関係をインストールします。
   ```bash
   mix deps.get
   ```

### 実行例

```elixir
isbn_list = [
  "9784480076403",
  "9784062938426",
  "9784334039868",
  "9784061596818",
  "9784309409351",
  "9784344430037",
  "9784167916480",
  "9784774196473"
]

OpenBDCSV.fetch_and_save_to_csv(isbn_list, "books.csv")
```

実行後、`books.csv` ファイルが生成され、取得した書籍データが保存されます。

### CSVフォーマット

生成されるCSVファイルの列は以下の通りです：

- ISBN
- タイトル (Title)
- 著者 (Author)
- 出版社 (Publisher)
- 出版日 (Published Date)
- 税込価格 (Price with Tax)
- 税抜価格 (Price without Tax)

## 設定とカスタマイズ

- **レートリミットの調整**： `@rate_limit_interval` でAPIリクエストの間隔（ミリ秒単位）を変更可能です。
- **消費税率の変更**： `@tax_rate` を変更することで、異なる税率に対応できます。

## ライセンス

このプロジェクトは [MITライセンス](LICENSE) のもとで公開されています。

## 作者

- **GitHub:** [curokami](https://github.com/curokami)




**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `openbdcsv` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:openbdcsv, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/openbdcsv>.


defmodule OpenBDCSV do
  require Logger

  @api_url "https://api.openbd.jp/v1/get?isbn="
  @tax_rate 0.10
  @rate_limit_interval 2000  # 2秒間隔でリクエストを送信

  def fetch_and_save_to_csv(isbn_list, output_file) do
    data =
      isbn_list
      |> Enum.map(&fetch_book_data_with_rate_limit/1)
      |> Enum.filter(&(&1 != nil))

    headers = ["ISBN", "Title", "Author", "Publisher", "Published Date", "Price (Tax Included)", "Price (Tax Excluded)"]

    File.write!(output_file, Enum.join(headers, ",") <> "\n")

    data
    |> Enum.each(fn book ->
      row = [
        book["isbn"],
        book["title"],
        book["author"],
        book["publisher"],
        book["pubdate"],
        book["price_incl_tax"],
        book["price_excl_tax"]
      ]

      File.write!(output_file, Enum.join(row, ",") <> "\n", [:append])
    end)

    Logger.info("CSVファイルが正常に保存されました: #{output_file}")

    # 保存した内容を標準出力
    output_file
    |> File.read!()
    |> IO.puts()
  end

  defp fetch_book_data_with_rate_limit(isbn) do
    result = fetch_book_data(isbn)
    :timer.sleep(@rate_limit_interval) # 2秒待機
    result
  end

  def fetch_book_data(isbn) do
    url = @api_url <> isbn

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, [book | _]} when is_map(book) ->
            extract_required_fields(book)
          _ ->
            Logger.warning("デコードエラーまたはデータなし: #{isbn}")
            nil
        end

      {:ok, %HTTPoison.Response{status_code: code}} ->
        Logger.warning("APIエラー (#{code}): #{isbn}")
        nil

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("HTTPリクエスト失敗: #{reason}")
        nil
    end
  end

  defp extract_required_fields(book) do
    onix = book["onix"] || %{}
    summary = book["summary"] || %{}

    price_incl_tax =
      case onix["ProductSupply"]["SupplyDetail"]["Price"] do
        [%{"PriceAmount" => amount}] ->
          case Integer.parse(amount) do
            {value, _} -> value
            :error -> 0
          end
        _ -> 0
      end

    price_excl_tax =
      if price_incl_tax > 0 do
        Float.floor(price_incl_tax / (1 + @tax_rate)) |> round()
      else
        0
      end

    %{
      "isbn" => summary["isbn"] || "",
      "title" => summary["title"] || "",
      "author" => summary["author"] || "",
      "publisher" => summary["publisher"] || "",
      "pubdate" => summary["pubdate"] || "",
      "price_incl_tax" => Integer.to_string(price_incl_tax),
      "price_excl_tax" => Integer.to_string(price_excl_tax)
    }
  end
end

# 使用例
# isbn_list = ["9784041029351", "9784062938426", "9784334039868", "9784101001014", "9784093865824", "9784163901892", "9784797399053", "9784845636543"]
# OpenBDCSV.fetch_and_save_to_csv(isbn_list, "books.csv")

defmodule GoogleTranslate do
  @moduledoc false

  require HTTPoison
  require URI

  def query(key, source, target, q) do
    result = get_arguments(key, source, target, q)
    result = http_poison(result)
    result = parse_response(result)
    result = parse_body(result)
    result
  end

  def http_poison(result) do
    result = HTTPoison.request(result["method"], result["url"], result["body"], result["headers"], result["options"])
    result
  end

  def parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    result = JSX.decode(body)
    result
  end

  def parse_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    result = {:error, status_code}
    result
  end

  def parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    result = {:error, reason}
    result
  end

  def parse_body({:ok, body}) do
    data = body["data"]
    translations = data["translations"]
    translation = Enum.at(translations, 0)
    result = {:ok, translation["translatedText"]}
    result
  end

  def parse_body({:error, reason}) do
    result = {:error, reason}
    result
  end

  def get_arguments(key, source, target, q) do
    method = :get
    url = "https://www.googleapis.com/language/translate/v2"
    body = ""
    headers = []
    params = [
      {"key", key},
      {"source", source},
      {"target", target},
      {"q", q},
    ]
    options = [
      {:params, params},
    ]
    result = %{
      "method" => method,
      "url" => url,
      "body" => body,
      "headers" => headers,
      "options" => options,
    }
    result
  end
end

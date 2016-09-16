defmodule GoogleCom do
  @moduledoc false

  require HTTPoison
  require URI

  def query(key, source, target, q) do
    method = :get
    url = "https://www.googleapis.com/language/translate/v2"
    body = ""
    headers = []
    params = [
      {"key", key},
      {"source", source},
      {"target", target},
      {"q", q}
    ]
    options = [
      {:params, params}
    ]
    result = parse_http(HTTPoison.request(method, url, body, headers, options))
    result
  end

  def parse_http({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    result = JSX.decode(body)
    result = parse_json(result)
    result
  end

  def parse_http({:ok, %HTTPoison.Response{status_code: status_code}}) do
    result = {:error, status_code}
    result
  end

  def parse_http({:error, %HTTPoison.Error{reason: reason}}) do
    result = {:error, reason}
    result
  end

  def parse_json({:ok, body}) do
    data = body["data"]
    translations = data["translations"]
    translation = Enum.at(translations, 0)
    result = {:ok, translation["translatedText"]}
    result
  end

  def parse_json({:error, reason}) do
    result = {:error, reason}
    result
  end
end

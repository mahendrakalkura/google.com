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
    response = parse_http(HTTPoison.request(method, url, body, headers, options))
    response
  end

  def parse_http({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    response = parse_json(body)
    response
  end

  def parse_http({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, status_code}
  end

  def parse_http({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def parse_json(body) do
    case JSX.decode(body) do
      {:ok, body} ->
        data = body["data"]
        translations = data["translations"]
        translation = Enum.at(translations, 0)
        {:ok, translation["translatedText"]}
      {:error, reason} ->
        {:error, reason}
    end
  end
end

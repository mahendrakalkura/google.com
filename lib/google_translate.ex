defmodule GoogleTranslate do
  @moduledoc false

  def query(key, source, target, q) do
    arguments = get_arguments(key, source, target, q)
    response = http_poison(arguments)
    body = parse_response(response)
    parse_body(body)
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
    %{
      "method" => method,
      "url" => url,
      "body" => body,
      "headers" => headers,
      "options" => options,
    }
  end

  def http_poison(arguments) do
    HTTPoison.request(
      arguments["method"],
      arguments["url"],
      arguments["body"],
      arguments["headers"],
      arguments["options"]
    )
  end

  def parse_response(
    {:ok, %HTTPoison.Response{status_code: 200, body: body}}
  ) do
    JSX.decode(body)
  end

  def parse_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, status_code}
  end

  def parse_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def parse_body({:ok, body}) do
    data = body["data"]
    translations = data["translations"]
    translation = Enum.at(translations, 0)
    {:ok, translation["translatedText"]}
  end

  def parse_body({:error, reason}) do
    {:error, reason}
  end
end

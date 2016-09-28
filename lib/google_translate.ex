defmodule GoogleTranslate do
  @moduledoc false

  def query(key, source, target, q) do
    arguments = get_arguments(key, source, target, q)
    response = http_poison(arguments)
    body = parse_response(response)
    parse_body(body)
  end

  def get_arguments(key, source, target, q) do
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
      "method" => :get,
      "url" => "https://www.googleapis.com/language/translate/v2",
      "body" => "",
      "headers" => [],
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

  def parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        JSX.decode(body)
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, status_code}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  def parse_body(body) do
    case body do
      {:ok, contents} ->
        data = contents["data"]
        translations = data["translations"]
        translation = Enum.at(translations, 0)
        {:ok, translation["translatedText"]}
      {:error, reason} -> {:error, reason}
    end
  end
end

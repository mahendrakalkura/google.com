defmodule GoogleTranslateAPI do
  @moduledoc false

  require HTTPoison
  require URI

  def get_translated_string(key, source, target, q) do
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
    get_response(HTTPoison.request(method, url, body, headers, options))
  end

  def get_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    get_response(body)
  end

  def get_response({:ok, %HTTPoison.Response{status_code: status_code}}) do
    {:error, status_code}
  end

  def get_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  def get_response(body) do
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

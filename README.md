How to install?
===============

1. Add `:google_translate_api` to `def application()` in your `mix.exs`.

```
def application() do
  [
    applications: [
      ...
      :google_translate_api,
      ...
    ]
  ]
end
```

2. Add `:google_translate_api` to `def deps()` in your `mix.exs`.

```
def deps do
  [
    ...
    {:google_translate_api, git: "https://github.com/mahendrakalkura/google_translate_api.git"},
    ...
  ]
end
```

3. Execute `mix deps.get`.

How to use?
===========

```
$ iex -S mix
iex(1)> GoogleTranslateAPI.get_translated_string("...{key}...", "en", "fr", "Hello World")
{:ok, "Bonjour le monde"}
```

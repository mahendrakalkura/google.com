How to install?
===============

Step 1: Add `:google_translate_api` to `def application()` in your `mix.exs`.

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

Step 2: Add `:google_translate_api` to `def deps()` in your `mix.exs`.

```
def deps do
  [
    ...
    {:google_translate_api, git: "https://github.com/mahendrakalkura/google_translate_api.git"},
    ...
  ]
end
```

Step 3: Execute `mix deps.get`.

How to use?
===========

```
$ iex -S mix
iex(1)> GoogleTranslateAPI.get_translated_string("...{key}...", "en", "fr", "Hello World")
{:ok, "Bonjour le monde"}
```

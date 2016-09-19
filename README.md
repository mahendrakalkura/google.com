How to install?
===============

Step 1
------

Add `:google_translate` to `def application()` in your `mix.exs`.

```
def application() do
  [
    applications: [
      ...
      :google_translate,
      ...
    ]
  ]
end
```

Step 2
------

Add `:google_translate` to `def deps()` in your `mix.exs`.

```
def deps do
  [
    ...
    {:google_translate, git: "https://github.com/mahendrakalkura/google_translate.git"},
    ...
  ]
end
```

Step 3
------

Execute `mix deps.get`.

How to use?
===========

```
$ iex -S mix
iex(1)> GoogleTranslate.query("...{a valid key}...", "en", "fr", "Hello World")
{:ok, "Bonjour le monde"}
iex(1)> GoogleTranslate.query("...{an invalid key}...", "en", "fr", "Hello World")
{:error, 400}
```

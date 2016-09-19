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
    {
      :google_translate,
      git: "https://github.com/mahendrakalkura/google_translate.git",
    },
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
iex(1)> GoogleTranslate.query(
...(1)>   "...{a valid key}...",
...(1)>   "en",
...(1)>   "fr",
...(1)>   "Hello World"
...(1)> )
{:ok, "Bonjour le monde"}
iex(2)> GoogleTranslate.query(
...(2)>   "...{an invalid key}...",
...(2)>   "en",
...(2)>   "fr",
...(2)>   "Hello World"
...(2)> )
{:error, 400}
```

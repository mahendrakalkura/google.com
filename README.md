How to install?
===============

Step 1
------

Add `:google` to `def application()` in your `mix.exs`.

```
def application() do
  [
    applications: [
      ...
      :google,
      ...
    ]
  ]
end
```

Step 2
------

Add `:google` to `def deps()` in your `mix.exs`.

```
def deps do
  [
    ...
    {:google, git: "https://github.com/mahendrakalkura/google.com.git"},
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
iex(1)> Google.query("...{a valid key}...", "en", "fr", "Hello World")
{:ok, "Bonjour le monde"}
iex(1)> Google.query("...{an invalid key}...", "en", "fr", "Hello World")
{:error, 400}
```

How to install?
===============

Step 1
------

Add `:google_com` to `def application()` in your `mix.exs`.

```
def application() do
  [
    applications: [
      ...
      :google_com,
      ...
    ]
  ]
end
```

Step 2
------

Add `:google_com` to `def deps()` in your `mix.exs`.

```
def deps do
  [
    ...
    {:google_com, git: "https://github.com/mahendrakalkura/google.com.git"},
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
iex(1)> GoogleCom.query("...{a valid key}...", "en", "fr", "Hello World")
{:ok, "Bonjour le monde"}
iex(1)> GoogleCom.query("...{an invalid key}...", "en", "fr", "Hello World")
{:error, 400}
```

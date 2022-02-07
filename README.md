# ExConnpass

Elixir wrapper for [connpass api](https://connpass.com/about/api/).

## Installation

```elixir
def deps do
  [
    {:ex_connpass, git: "https://github.com/koga1020/ex_connpass.git"}
  ]
end
```

## Usage

```console
$ mix deps.get
$ iex -S mix
```

```elixir
iex> ExConnpass.run(%{query: [keyword: "elixir"]})
```

## Config

If you want to change the domain when running the test, you can change api_base_url like this:

```elixir
import Config

config :ex_connpass, api_base_url: "http://localhost:8081/"
```

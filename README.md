# ExConnpass

Elixir wrapper for [connpass api](https://connpass.com/about/api/).

## Installation

```elixir
def deps do
  [
    {:ex_connpass, "~> 0.2.1"}
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

Since ex_connpass uses [commandex](https://github.com/codedge-llc/commandex/), the return value will look like this.

```elixir
%ExConnpass{
  data: %{api_url: nil, events: nil, response: nil},
  errors: %{},
  halted: false,
  params: %{query: nil},
  pipelines: [:build_url, :call_api, :decode],
  success: false
}
```

To retrieve the results of the API, like this:

```elixir
ExConnpass.run(%{query: [keyword: "elixir"]})
|> case do
  %{success: true, data: %{events: events}} ->
    # use events...

  %{success: false} ->
    # error handling...
end
```


## Config

If you want to change the domain when running the test, you can change api_base_url like this:

```elixir
import Config

config :ex_connpass, api_base_url: "http://localhost:8081/"
```

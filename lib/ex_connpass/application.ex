defmodule ExConnpass.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    children =
      case args do
        [env: :test] ->
          [{Plug.Cowboy, scheme: :http, plug: ExConnpass.MockServer, options: [port: 8081]}]

        _ ->
          []
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExConnpass.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

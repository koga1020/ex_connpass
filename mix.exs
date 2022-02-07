defmodule ExConnpass.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_connpass,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExConnpass.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8.0"},
      {:jason, "~> 1.3.0"},
      {:plug_cowboy, "~> 2.0", only: :test}
    ]
  end
end

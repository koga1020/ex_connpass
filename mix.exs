defmodule ExConnpass.MixProject do
  use Mix.Project

  @version "0.2.1"
  @scm_url "https://github.com/koga1020/ex_connpass"

  def project do
    [
      app: :ex_connpass,
      version: @version,
      elixir: "~> 1.13",
      source_url: @scm_url,
      description: "Elixir wrapper for connpass api.",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExConnpass.Application, [env: Mix.env()]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:commandex, "~> 0.4.1"},
      {:ex_doc, "~> 0.28.0", only: :dev, runtime: false},
      {:httpoison, "~> 1.8.0"},
      {:jason, "~> 1.3.0"},
      {:plug_cowboy, "~> 2.0"},
      {:git_ops, "~> 2.4.5", only: [:dev]}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => @scm_url}
    ]
  end
end

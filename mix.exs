defmodule DiscordBotList.MixProject do
  use Mix.Project

  def project do
    [
      app: :discord_bot_list,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "DiscordBotList",
      source_url: "https://github.com/zastrixarundell/discordbotlist",
      docs: [
        main: "DiscordBotList", # The main page in the docs
        logo: "assets/index.svg",
        extras: ["README.md"]
      ]
    ]
  end

  defp description() do
    "Unofficial Elixir library for the top.gg API"
  end

  defp package() do
    [
      name: "discord_bot_list",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README* CHANGELOG*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/zastrixarundell/discordbotlist"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {DiscordBotList.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:httpoison, "~> 1.6"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

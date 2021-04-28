defmodule Brawlex.MixProject do
  use Mix.Project

  def project do
    [
      app: :brawlex,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Brawlex.Application, []},
      registered: [BrawlBrain]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.6"},
      {:ex_doc, "~> 0.24", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:json, "~> 1.4"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    """
    Api client for Brawl Stars API made on top of finch
    """
  end

  defp package do
    %{
      licenses: ["MIT License"],
      maintainers: ["Jorge Vergés"],
      links: %{"GitHub" => "https://github.com/SirWerto/brawlex"}
    }
  end

end

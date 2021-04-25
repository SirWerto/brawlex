# Brawlex

Api client for Brawl Stars API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `brawlex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:brawlex, "~> 0.1.0"}
  ]
end
```

## Usage

First of all, you need a Token binding to your current IP. Get one here  https://developer.brawlstars.com.

Second, this is an application, so it is necesary to start it before start doing requests.

Go to mix.exs and append it:

```elixir
  def application do
    [
      extra_applications: [:logger, :brawlex],
    ]
  end
```
and now you are ready to use it:)

```elixir
	{:ok, token_id} = File.read("token.txt")
	{:ok, tpid} = Brawlex.open_connection(token_id)

        Brawlex.get_brawlers(tpid)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/brawlex](https://hexdocs.pm/brawlex).


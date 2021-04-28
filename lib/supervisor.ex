defmodule Brawlex.Supervisor do
  use Supervisor
  @moduledoc false

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {Finch, [name: BrawlerFinch]},
      {Brawlex.BrawlBrain, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

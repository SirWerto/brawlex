defmodule Brawlex.DynamicSupervisor do
  use DynamicSupervisor
  @moduledoc false

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, [])
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end

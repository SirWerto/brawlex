defmodule Brawlex.TokenProcess do
  use GenServer


  def start_link(token_id) do
    GenServer.start_link(__MODULE__, token_id)
  end

  @impl true
  def init(token_id) do
    {:ok, token_id}
  end


  @impl true
  def handle_call(_msg, _from, token_id) do
    {:noreply, token_id}
  end
  @impl true
  def handle_call(_msg, _from, token_id) do
    {:noreply, token_id}
  end



  @impl true
  def handle_cast(:close, token_id) do
    Brawlex.BrawlBrain.close_connection(token_id)
    {:stop, :normal, {}}
  end

  @impl true
  def handle_cast(_msg, token_id) do
    {:noreply, token_id}
  end

end



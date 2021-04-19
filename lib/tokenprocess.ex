defmodule Brawlex.TokenProcess do
  use GenServer


#{:ok, conn} = Mint.HTTP.connect(:https, "https://api.brawlstars.com", 443)
#headers = [{"Accept", "application/json"}, {"authorization": "Bearer " <> token_id}]
#{:ok, conn, request_ref} = Mint.HTTP.request(conn, "GET", "/v1/brawlers", headers, nil)


  def start_link(token_id) do
    GenServer.start_link(__MODULE__, token_id)
  end

  @impl true
  def init(token_id) do
    headers = [{"Accept", "application/json"}, {"authorization", "Bearer " <> token_id}, {"User-Agent", "Brawlex"}]
    {:ok, {token_id, headers}}
  end


  @impl true
  def handle_call(:brawlers, _from, {token_id, headers}) do
    case Finch.build(:get, "https://api.brawlstars.com/v1/brawlers", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case parse(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  any -> {:reply, {:error, any}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
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

  defp parse(%{:status => 200, :body => body, :headers => _headers}) do
    JSON.decode(body)
  end

#### INTERFAZE


  @spec get_brawlers(pid(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_brawlers(tpid, timeout \\ 5000) do
    try do
      GenServer.call(tpid, :brawlers, timeout)
    catch
      :exit , error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
    end
  end


  @spec close_connection(pid()) :: :ok
  def close_connection(tpid) do
    GenServer.cast(tpid, :close)
  end



end




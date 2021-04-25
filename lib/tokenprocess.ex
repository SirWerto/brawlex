defmodule Brawlex.TokenProcess do
  use GenServer


#{:ok, conn} = Mint.HTTP.connect(:https, "https://api.brawlstars.com", 443)
#headers = [{"Accept", "application/json"}, {"authorization": "Bearer " <> token_id}]
#{:ok, conn, request_ref} = Mint.HTTP.request(conn, "GET", "/v1/brawlers", headers, nil)

@url_api "https://api.brawlstars.com/v1/"


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
    case Finch.build(:get, @url_api <> "brawlers", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_brawlers(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  @impl true
  def handle_call({:brawler, id}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "brawlers/" <> id, headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_brawler(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  @impl true
  def handle_call({:ranking_players, country_code}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "rankings/" <> country_code <> "/players", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_ranking_players(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  @impl true
  def handle_call({:ranking_clubs, country_code}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "rankings/" <> country_code <> "/clubs", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_ranking_clubs(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  @impl true
  def handle_call({:ranking_brawlers, country_code, brawler_id}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "rankings/" <> country_code <> "/brawlers/" <> brawler_id, headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_multiple(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  def handle_call({:ranking_seasons, country_code}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "rankings/" <> country_code <> "/powerplay/seasons", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_multiple(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  def handle_call({:ranking_season, country_code, season_id}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "rankings/" <> country_code <> "/powerplay/seasons/" <> season_id, headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_multiple(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  def handle_call({:club, club_tag}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "clubs/" <> club_tag, headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_single(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  def handle_call({:club_members, club_tag}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "clubs/" <> club_tag <> "/members", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_multiple(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  def handle_call({:player, player_tag}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "players/" <> player_tag, headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_single(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
	end
      any -> {:reply, {:error, any}, {token_id, headers}}
    end
  end

  def handle_call({:player_battlelog, player_tag}, _from, {token_id, headers}) do
    case Finch.build(:get, @url_api <> "players/" <> player_tag <> "/battlelog", headers) |> Finch.request(BrawlerFinch) do
      {:ok, response} ->
	case Brawlex.Parse.get_multiple(response) do
	  {:ok, data} -> {:reply, {:ok, data}, {token_id, headers}}
	  {:error, reason} -> {:reply, {:error, reason}, {token_id, headers}}
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


end




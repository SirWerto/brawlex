defmodule Brawlex.TokenInterface do
  @spec get_brawlers(pid(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_brawlers(tpid, timeout \\ 5000) do
    try do
      GenServer.call(tpid, :brawlers, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_brawler(pid(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_brawler(tpid, brawler_id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:brawler, brawler_id}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_ranking_players(pid(), Brawlex.country_code(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_players(tpid, country_c, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_players, country_c}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_ranking_clubs(pid(), Brawlex.country_code(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_clubs(tpid, country_c, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_clubs, country_c}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_ranking_brawlers(pid(), Brawlex.country_code(), String.t(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_brawlers(tpid, country_c, brawler_id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_brawlers, country_c, brawler_id}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_ranking_seasons(pid(), Brawlex.country_code(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_seasons(tpid, country_c, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_seasons, country_c}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_ranking_season(pid(), Brawlex.country_code(), String.t(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_season(tpid, country_c, season_id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_season, country_c, season_id}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_club(pid(), Brawlex.tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_club(tpid, club_tag, timeout \\ 5000) do
    case eval_tag(club_tag) do
      {:ok, new_tag} ->
        try do
          GenServer.call(tpid, {:club, new_tag}, timeout)
        catch
          :exit, error -> {:error, error}
        else
          {:ok, res} -> {:ok, res}
          {:error, reason} -> {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec get_club_members(pid(), Brawlex.tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_club_members(tpid, club_tag, timeout \\ 5000) do
    case eval_tag(club_tag) do
      {:ok, new_tag} ->
        try do
          GenServer.call(tpid, {:club_members, new_tag}, timeout)
        catch
          :exit, error -> {:error, error}
        else
          {:ok, res} -> {:ok, res}
          {:error, reason} -> {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec get_player(pid(), Brawlex.tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_player(tpid, player_tag, timeout \\ 5000) do
    case eval_tag(player_tag) do
      {:ok, new_tag} ->
        try do
          GenServer.call(tpid, {:player, new_tag}, timeout)
        catch
          :exit, error -> {:error, error}
        else
          {:ok, res} -> {:ok, res}
          {:error, reason} -> {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec get_player_battlelog(pid(), Brawlex.tag(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_player_battlelog(tpid, player_tag, timeout \\ 5000) do
    case eval_tag(player_tag) do
      {:ok, new_tag} ->
        try do
          GenServer.call(tpid, {:player_battlelog, new_tag}, timeout)
        catch
          :exit, error -> {:error, error}
        else
          {:ok, res} -> {:ok, res}
          {:error, reason} -> {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec close_connection(pid()) :: :ok
  def close_connection(tpid) do
    GenServer.cast(tpid, :close)
  end

  @spec eval_tag(Brawlex.tag()) :: {:ok, String.t()} | {:error, any()}
  defp eval_tag(<<"#", some_tag::binary>>) do
    {:ok, <<"%23", some_tag::binary>>}
  end

  defp eval_tag(_bad_tag) do
    {:error, :tag_without_sharp}
  end
end

defmodule Brawlex.TokenInterface do

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

  @spec get_brawler(pid(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_brawler(tpid, id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:brawler, id}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
    end
  end

  @spec get_ranking_players(pid(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_players(tpid, id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_players, id}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
    end
  end

  @spec get_ranking_clubs(pid(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_clubs(tpid, id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_clubs, id}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
    end
  end

  @spec get_ranking_brawlers(pid(), String.t(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_brawlers(tpid, country_code, brawler_id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_brawlers, country_code, brawler_id}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
    end
  end

  @spec get_ranking_seasons(pid(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_seasons(tpid, country_c, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_seasons, country_c}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      {:ok, res} -> {:ok, res}
    end
  end

  @spec get_ranking_season(pid(), String.t(), String.t(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_season(tpid, country_c, season_id, timeout \\ 5000) do
    try do
      GenServer.call(tpid, {:ranking_season, country_c, season_id}, timeout)
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

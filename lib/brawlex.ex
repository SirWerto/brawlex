defmodule Brawlex do
  @moduledoc """
  Documentation for `Brawlex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Brawlex.hello()
      :world

  """


  @typedoc """
  The Brawl Stars api token for authentication. You can get it from https://developer.brawlstars.com
  """
  @type token :: String.t

  @typedoc """
  Game's internal ID for players and clubs. It always start with '#'
  """
  @type tag :: String.t

  @typedoc """
  Two letter country code, or 'global' for global rankings.
  """
  @type country_code :: String.t


  @default_timeout 5000

  def hello do
    :world
  end

  @doc """
  Call the BrawlBrain to set up a new token_process for requests. If the token is alredy in use, just reference to it. Return `{:ok, pid}` in case of success or `{:error, reason}` in fail case.
  """
  @spec open_connection(token(), timeout()) :: {:ok, pid()} | {:error, any()}
  def open_connection(token_id, timeout \\ @default_timeout) do
    try do
      GenServer.call(BrawlBrain, {:new_token, token_id}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      bpid -> {:ok, bpid}
    end
  end

  @doc """
  Same as `open_connection` but in case of fail, it raise `Brawlex.Error`, otherwise, only just return the `pid`.
  """
  @spec open_connection!(token(), timeout()) :: pid()
  def open_connection!(token_id, timeout \\ @default_timeout) do
      GenServer.call(BrawlBrain, {:new_token, token_id}, timeout)
  end


  @doc """
  Shutdown the token_process.
  """
  @spec close_connection(pid()) :: :ok
  def close_connection(bpid) do
    GenServer.cast(bpid, :close)
  end

  @doc """
  Get list of available brawlers.
  """
  @spec get_brawlers(pid(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_brawlers(bpid, timeout \\ @default_timeout) do
    try do
      GenServer.call(bpid, {:brawlers}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      res -> {:ok, res}
    end
  end

  @doc """
  Same as `get_brawlers` but raise `Brawlex.Error` in case of fail.
  """
  @spec get_brawlers!(pid(), timeout()) :: list(map())
  def get_brawlers!(bpid, timeout \\ @default_timeout) do
    case get_brawlers(bpid, timeout) do
      {:ok, res} -> res
      _ -> {:error, :vacio_por_ahora}
    end
  end


  @doc """
  Get information about a brawler.
  """
  @spec get_brawler(pid(), String.t(), timeout()) :: {:ok, map()} | {:error, any()}
  def get_brawler(bpid, brawler_id, timeout \\ @default_timeout) do
    try do
      GenServer.call(bpid, {:brawler, brawler_id}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      res -> {:ok, res}
    end
  end

  @doc """
  Same as `get_brawler` but raise `Brawlex.Error` in case of fail.
  """
  @spec get_brawler!(pid(), String.t(), timeout()) :: {:ok, map()} | {:error, any()}
  def get_brawler!(bpid, brawler_id, timeout \\ @default_timeout) do
    case get_brawler(bpid, brawler_id, timeout) do
      {:ok, res} -> res
      _ -> {:error, :vacio_por_ahora}
    end
  end

  @doc """
  Get club rankings for a country or global rankings.
  """
  @spec get_ranking_clubs(pid(), country_code(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_clubs(bpid, country_c, limit, timeout \\ @default_timeout) do
    try do
      GenServer.call(bpid, {:ranking_clubs, country_c, limit}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      res -> {:ok, res}
    end
  end

  @doc """
  Same as `get_ranking_clubs` but raise `Brawlex.Error` in case of fail.
  """
  @spec get_ranking_clubs!(pid(), country_code(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_clubs!(bpid, country_c, limit, timeout \\ @default_timeout) do
    case get_ranking_clubs(bpid, country_c, limit, timeout) do
      {:ok, res} -> res
      _ -> {:error, :vacio_por_ahora}
    end
  end

  @doc """
  Get player rankings for a country or global rankings.
  """
  @spec get_ranking_players(pid(), country_code(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_players(bpid, country_c, limit, timeout \\ @default_timeout) do
    try do
      GenServer.call(bpid, {:ranking_players, country_c, limit}, timeout)
    catch
      :exit , error -> {:error, error}
    else
      res -> {:ok, res}
    end
  end

  @doc """
  Same as `get_ranking_players` but raise `Brawlex.Error` in case of fail.
  """
  @spec get_ranking_players!(pid(), country_code(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_players!(bpid, country_c, limit, timeout \\ @default_timeout) do
    case get_ranking_players(bpid, country_c, limit, timeout) do
      {:ok, res} -> res
      _ -> {:error, :vacio_por_ahora}
    end
  end

  @spec get_ranking_brawlers(pid(), country_code(), String.t(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_brawlers(bpid, country_c, brawler_id, limit, timeout \\ @default_timeout) do
    :paco
  end

  @spec get_ranking_seasons(pid(), country_code(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_seasons(bpid, country_c, limit, timeout \\ @default_timeout) do
    :paco
  end

  @spec get_ranking_season(pid(), country_code(), String.t(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_ranking_season(bpid, country_c, season_id, limit, timeout \\ @default_timeout) do
    :paco
  end

  @spec get_club(pid(), tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_club(bpid, club_tag, timeout \\ @default_timeout) do
    :paco
  end

  @spec get_club_members(pid(), tag(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_club_members(bpid, club_tag, limit, timeout \\ @default_timeout) do
    :paco
  end

  @spec get_player(pid(), tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_player(bpid, player_tag, timeout \\ @default_timeout) do
    :paco
  end

  @spec get_player_battlelog(pid(), tag(), pos_integer(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_player_battlelog(bpid, player_tag, limit, timeout \\ @default_timeout) do
    :paco
  end

end

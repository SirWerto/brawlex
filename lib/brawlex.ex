defmodule Brawlex do
  @moduledoc """
  Documentation for `Brawlex`.
  """

  @typedoc """
  The Brawl Stars api token for authentication. You can get it from https://developer.brawlstars.com
  """
  @type token :: String.t()

  @typedoc """
  Game's internal ID for players and clubs. It always start with '#'
  """
  @type tag :: String.t()

  @typedoc """
  Two letter country code, or 'global' for global rankings.
  """
  @type country_code :: String.t()

  @default_timeout 5000

  @doc """
  Call the BrawlBrain to set up a new token_process for requests. If the token is alredy in use and allow_duplicates is `false`, just reference to it. Return `{:ok, pid}` in case of success or `{:error, reason}` in fail case.
  """
  @spec open_connection(token(), boolean(), timeout()) :: {:ok, pid()} | {:error, any()}
  def open_connection(token_id, allow_duplicates, timeout \\ @default_timeout) do
    Brawlex.BrawlBrain.open_connection(token_id, allow_duplicates, timeout)
  end


  @doc """
  Shutdown the token_process.
  """
  @spec close_connection(pid()) :: :ok
  def close_connection(tpid) do
    Brawlex.TokenInterface.close_connection(tpid)
  end

  @doc """
  Get list of available brawlers.
  """
  @spec get_brawlers(pid(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_brawlers(tpid, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_brawlers(tpid, timeout)
  end

  @doc """
  Get information about a brawler.
  """
  @spec get_brawler(pid(), String.t(), timeout()) :: {:ok, map()} | {:error, any()}
  def get_brawler(tpid, brawler_id, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_brawler(tpid, brawler_id, timeout)
  end

  @doc """
  Get club rankings for a country or global rankings.
  """
  @spec get_ranking_clubs(pid(), country_code(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_clubs(tpid, country_c, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_ranking_clubs(tpid, country_c, timeout)
  end

  @doc """
  Get player rankings for a country or global rankings.
  """
  @spec get_ranking_players(pid(), country_code(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_players(tpid, country_c, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_ranking_players(tpid, country_c, timeout)
  end

  @doc """
  Get brawler rankings for a country or global rankings. Brawler identifiers can be found by using `get_brawlers` function.
  """
  @spec get_ranking_brawlers(pid(), country_code(), String.t(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_brawlers(tpid, country_c, brawler_id, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_ranking_brawlers(tpid, country_c, brawler_id, timeout)
  end

  @doc """
  Get list of power play seasons for a country or global rankings.
  """
  @spec get_ranking_seasons(pid(), country_code(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_seasons(tpid, country_c, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_ranking_seasons(tpid, country_c, timeout)
  end

  @doc """
  Get power play rankings for a country or global rankings. 'latest' can be used as seasonId to get rankings for the latest season.
  """
  @spec get_ranking_season(pid(), country_code(), String.t(), timeout()) ::
          {:ok, list(map())} | {:error, any()}
  def get_ranking_season(tpid, country_c, season_id, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_ranking_season(tpid, country_c, season_id, timeout)
  end

  @doc """
  Get information about a single clan by club tag. 
  """
  @spec get_club(pid(), tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_club(tpid, club_tag, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_club(tpid, club_tag, timeout)
  end

  @doc """
  List club members.
  """
  @spec get_club_members(pid(), tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_club_members(tpid, club_tag, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_club_members(tpid, club_tag, timeout)
  end

  @doc """
  Get information about a single player by player tag. 
  """
  @spec get_player(pid(), tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_player(tpid, player_tag, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_player(tpid, player_tag, timeout)
  end

  @doc """
  Get list of recent battle results for a player. NOTE: It may take up to 30 minutes for a new battle to appear in the battlelog.
  """
  @spec get_player_battlelog(pid(), tag(), timeout()) :: {:ok, list(map())} | {:error, any()}
  def get_player_battlelog(tpid, player_tag, timeout \\ @default_timeout) do
    Brawlex.TokenInterface.get_player_battlelog(tpid, player_tag, timeout)
  end
end

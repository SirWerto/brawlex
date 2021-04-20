defmodule Brawlex.Parse do


  def get_brawlers(%{:status => 200, :body => body, :headers => _headers}) do
    {:ok, map_answer} = JSON.decode(body)
    {:ok, map_answer["items"]}
  end

  def get_brawlers(%{:status => code, :body => body, :headers => _headers}) do
    {:error, {code, body}}
  end


  def get_brawler(%{:status => 200, :body => body, :headers => _headers}) do
    JSON.decode(body)
  end

  def get_brawler(%{:status => code, :body => body, :headers => _headers}) do
    {:error, {code, body}}
  end
end
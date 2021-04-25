defmodule Brawlex.Parse do
  def get_single(%{:status => 200, :body => body, :headers => _headers}) do
    JSON.decode(body)
  end

  def get_single(%{:status => code, :body => body, :headers => _headers}) do
    {:error, {code, body}}
  end

  def get_multiple(%{:status => 200, :body => body, :headers => _headers}) do
    {:ok, map_answer} = JSON.decode(body)
    {:ok, map_answer["items"]}
  end

  def get_multiple(%{:status => code, :body => body, :headers => _headers}) do
    {:error, {code, body}}
  end
end

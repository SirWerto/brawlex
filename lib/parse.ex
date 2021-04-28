defmodule Brawlex.Parse do
  @moduledoc false
  def get_single(%{:status => 200, :body => body, :headers => _headers}) do
    JSON.decode(body)
  end

  def get_single(%{:status => 400, :body => body, :headers => _headers}) do
    {:error, {{400, :bad_parameters}, body}}
  end
  
  def get_single(%{:status => 403, :body => body, :headers => _headers}) do
    {:error, {{403, :access_denied}, body}}
  end

  def get_single(%{:status => 404, :body => body, :headers => _headers}) do
    {:error, {{404, :resource_not_found}, body}}
  end

  def get_single(%{:status => 429, :body => body, :headers => _headers}) do
    {:error, {{429, :too_many_requests}, body}}
  end

  def get_single(%{:status => 500, :body => body, :headers => _headers}) do
    {:error, {{500, :unknown_server_error}, body}}
  end

  def get_single(%{:status => 503, :body => body, :headers => _headers}) do
    {:error, {{503, :service_temporary_unavailable}, body}}
  end

  def get_single(%{:status => code, :body => body, :headers => _headers}) do
    {:error, {code, body}}
  end




  def get_multiple(%{:status => 200, :body => body, :headers => _headers}) do
    {:ok, map_answer} = JSON.decode(body)
    {:ok, map_answer["items"]}
  end

  def get_multiple(%{:status => 400, :body => body, :headers => _headers}) do
    {:error, {{400, :bad_parameters}, body}}
  end
  
  def get_multiple(%{:status => 403, :body => body, :headers => _headers}) do
    {:error, {{403, :access_denied}, body}}
  end

  def get_multiple(%{:status => 404, :body => body, :headers => _headers}) do
    {:error, {{404, :resource_not_found}, body}}
  end

  def get_multiple(%{:status => 429, :body => body, :headers => _headers}) do
    {:error, {{429, :too_many_requests}, body}}
  end

  def get_multiple(%{:status => 500, :body => body, :headers => _headers}) do
    {:error, {{500, :unknown_server_error}, body}}
  end

  def get_multiple(%{:status => 503, :body => body, :headers => _headers}) do
    {:error, {{503, :service_temporary_unavailable}, body}}
  end

  def get_multiple(%{:status => code, :body => body, :headers => _headers}) do
    {:error, {code, body}}
  end
end

defmodule Brawlex.BrawlBrain do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Callbacks

  @impl true
  def init(_x) do
    # send message to initialize the dynamicsupervisor
    send(self(), :init_dynsuper)
    {:ok, {%{}, %{}}}
  end

  @impl true
  def handle_info(:init_dynsuper, state) do
    child_specs = {Brawlex.DynamicSupervisor, []}

    {:ok, spid} = Supervisor.start_child(Brawlex.Supervisor, child_specs)
    _sref = Process.monitor(spid)
    {:noreply, {spid, state}}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, spid, reason}, {spid, _state}) do
    {:stop, {:supersuper_down, reason}, []}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, tpid, _reason}, {spid, {tokens, refs}}) do
    case refs[tpid] do
      nil ->
        # not our problem
        {:noreply, {spid, {tokens, refs}}}

      token ->
        new_tokens = Map.delete(tokens, token)
        new_refs = Map.delete(refs, tpid)
        {:noreply, {spid, {new_tokens, new_refs}}}
    end
  end

  @impl true
  def handle_info(_msg, state) do
    # not our problem
    {:noreply, state}
  end

  @impl true
  def handle_call({:new_token, token_id}, _from, state = {spid, {tokens, refs}}) do
    case tokens[token_id] do
      nil ->
        case DynamicSupervisor.start_child(spid, {Brawlex.TokenProcess, token_id}) do
          {:ok, child} ->
            ref_child = Process.monitor(child)
            new_tokens = Map.put(tokens, token_id, {ref_child, child})
            new_refs = Map.put(refs, child, token_id)
            {:reply, child, {spid, {new_tokens, new_refs}}}

          {:error, reason} ->
            {:reply, {:error, {:unable_to_open, reason}}, state}
        end

      {_ref, tpid} ->
        {:reply, tpid, state}
    end
  end

  @impl true
  def handle_call(_msg, _from, state) do
    {:noreply, state}
  end

  @impl true
  def handle_cast({:close, token_id}, state = {spid, {tokens, refs}}) do
    case tokens[token_id] do
      nil ->
        {:noreply, state}

      {ref, _tpid} ->
        new_tokens = Map.delete(tokens, token_id)
        new_refs = Map.delete(refs, ref)
        Process.demonitor(ref, [:flush])
        {:noreply, {spid, {new_tokens, new_refs}}}
    end
  end

  @impl true
  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  ### Interface ###

  @spec open_connection(Brawlex.token(), timeout()) :: {:ok, pid()} | {:error, any()}
  def open_connection(token_id, timeout \\ 5000) do
    try do
      GenServer.call(Brawlex.BrawlBrain, {:new_token, token_id}, timeout)
    catch
      :exit, error -> {:error, error}
    else
      tpid -> {:ok, tpid}
    end
  end

  @spec close_connection(Brawlex.token()) :: :ok
  def close_connection(token_id) do
    GenServer.cast(Brawlex.BrawlBrain, {:close, token_id})
  end
end

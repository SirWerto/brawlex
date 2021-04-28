defmodule BrawlexTest do
  use ExUnit.Case
  doctest Brawlex


  test "create tokenprocess" do
    {:ok, tpid} = Brawlex.open_connection("some_token")
    assert Kernel.is_pid(tpid)
  end

  test "same key, same tokenprocess" do
    {:ok, tpid1} = Brawlex.open_connection("some_token")
    {:ok, tpid2} = Brawlex.open_connection("some_token")
    assert tpid1 == tpid2
  end

  test "close tokenprocess" do
    {:ok, tpid} = Brawlex.open_connection("some_token")
    ref = Process.monitor(tpid)
    :ok = Brawlex.close_connection(tpid)

    receive do
      {:DOWN, ^ref, :process, _object, _reason} ->
        assert true
    after
      5_000 ->
        assert false
    end
  end

  test "ensure brawlbrain close tokenprocess" do
    {:ok, tpid} = Brawlex.open_connection("some_token")
    :ok = Brawlex.close_connection(tpid)

    Process.sleep(5_000)
    {:ok, tpid2} = Brawlex.open_connection("some_token")

    assert tpid != tpid2
  end

end

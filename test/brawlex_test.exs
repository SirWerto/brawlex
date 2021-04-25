defmodule BrawlexTest do
  use ExUnit.Case
  doctest Brawlex

  setup_all do
    {:ok, token_id} = File.read("test/token_test.txt")
    {:ok, token: token_id}
  end

  test "create tokenprocess", context do
    {:ok, tpid} = Brawlex.open_connection(context[:token])
    assert Kernel.is_pid(tpid)
  end

  test "same key, same tokenprocess", context do
    {:ok, tpid1} = Brawlex.open_connection(context[:token])
    {:ok, tpid2} = Brawlex.open_connection(context[:token])
    assert tpid1 == tpid2
  end

  test "close tokenprocess", context do
    {:ok, tpid} = Brawlex.open_connection(context[:token])
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
end

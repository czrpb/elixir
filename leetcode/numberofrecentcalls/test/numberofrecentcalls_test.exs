defmodule NumberOfRecentCallsTest do
  use ExUnit.Case
  doctest NumberOfRecentCalls

  setup_all do
    {:ok, _pid} = NumberOfRecentCalls.start_link()
    :ok
  end

  describe "pings: 1, 100, 3001, 3002 -> [1, 2, 3, 3] >" do
    test "init" do
      assert NumberOfRecentCalls.state() == []
    end

    test "ping: 1" do
      assert NumberOfRecentCalls.ping(1) == 1
      assert NumberOfRecentCalls.state() == [1]
    end

    test "ping: 100" do
      assert NumberOfRecentCalls.ping(100) == 2
      assert NumberOfRecentCalls.state() == [100, 1]
    end

    test "ping: 3001" do
      assert NumberOfRecentCalls.ping(3001) == 3
      assert NumberOfRecentCalls.state() == [3001, 100, 1]
    end

    test "ping: 3002" do
      assert NumberOfRecentCalls.ping(3002) == 3
      assert NumberOfRecentCalls.state() == [3002, 3001, 100, 1 ]
    end
  end
end

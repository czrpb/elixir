defmodule TwosumTest do
  use ExUnit.Case
  doctest Twosum

  @tag timeout: 100000
  test "5000 random numbers" do
    list = 0..10000 |> Enum.shuffle
    i1 = :rand.uniform(1001)-1
    v1 = Enum.at(list, i1)
    i2 = :rand.uniform(1001)-1
    v2 = Enum.at(list, i2)
    target = v1 + v2
    IO.puts("\nStarting...")
    {ms, [ni1, ni2]} = :timer.tc(fn -> Twosum.twosum([target|list]) |> Enum.sort end)
    nv1 = Enum.at(list, ni1)
    nv2 = Enum.at(list, ni2)
    new_target = nv1 + nv2
    IO.puts("\ttarget: #{target}, found #{nv1} at #{ni1} and #{nv2} at #{ni2} in #{ms/1000000}secs")
    assert target == new_target
  end
end

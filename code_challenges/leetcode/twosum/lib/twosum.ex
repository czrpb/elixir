defmodule Twosum do
  @moduledoc """
  Documentation for `Twosum`.
  """

  @doc """
  iex> Twosum.twosum([6,3,3]) |> Enum.sort
  [0, 1]

  iex> Twosum.twosum([9,2,7,11,15]) |> Enum.sort
  [0, 1]

  iex> Twosum.twosum([6,3,2,4]) |> Enum.sort
  [1, 2]
  """
  def twosum([target|list]) do
    list
    |> Enum.with_index
    |> Combination.combine(2)
    |> Stream.filter(fn [{n1, _}, {n2, _}] -> n1+n2 == target end)
    |> Enum.take(1)
    |> (fn [[{_, i1}, {_, i2}]] -> [i1, i2] end).()
  end
end

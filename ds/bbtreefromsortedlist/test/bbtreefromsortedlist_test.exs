defmodule BBTreeFromSortedListTest do
  use ExUnit.Case
  doctest BBTreeFromSortedList

  test "[1,2,3]" do
    input = 1..3 |> Enum.to_list
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5]" do
    input = 1..5 |> Enum.to_list
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7]" do
    input = 1..7 |> Enum.to_list
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7,8,9]" do
    input = 1..9 |> Enum.to_list
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end
end

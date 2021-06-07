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
    expected = {
      {{nil, 1, nil}, 2, nil},
      3,
      {{nil, 4, nil}, 5, nil}
    }
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7]" do
    input = 1..7 |> Enum.to_list
    expected = {
      {{nil, 1, nil}, 2, {nil, 3, nil}},
      4,
      {{nil, 5, nil}, 6, {nil, 7, nil}}
    }
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7,8,9]" do
    input = 1..9 |> Enum.to_list
    expected = {
      {{{nil, 1, nil}, 2, nil}, 3, {nil, 4, nil}},
      5,
      {{{nil, 6, nil}, 7, nil}, 8, {nil, 9, nil}}
    }
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7,8,9,10,11]" do
    input = 1..11 |> Enum.to_list
    expected = {
      {{{nil, 1, nil}, 2, nil}, 3, {{nil, 4, nil}, 5, nil}},
      6,
      {{{nil, 7, nil}, 8, nil}, 9, {{nil, 10, nil}, 11, nil}}
    }
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7,8,9,10,11,12,13]" do
    input = 1..13 |> Enum.to_list
    expected = {
      {
        {{nil, 1, nil}, 2, {nil, 3, nil}},
        4,
        {{nil, 5, nil}, 6, nil}
      },
      7,
      {
        {{nil, 8, nil}, 9, {nil, 10, nil}},
        11,
        {{nil, 12, nil}, 13, nil}
      }
    }
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

  test "[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]" do
    input = 1..15 |> Enum.to_list
    expected = {
      {
        {{nil, 1, nil}, 2, {nil, 3, nil}},
        4,
        {{nil, 5, nil}, 6, {nil, 7, nil}}
      },
      8,
      {
        {{nil, 9, nil}, 10, {nil, 11, nil}},
        12,
        {{nil, 13, nil}, 14, {nil, 15, nil}}
      }
    }
    assert BBTreeFromSortedList.from_sorted(input) == expected
  end

end

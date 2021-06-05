defmodule BBTreeTest do
  use ExUnit.Case
  doctest BBTree

  test "[1, 2, 3]" do
    input = [1, 2, 3]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}

    tree = BBTree.new(input)
    depth = BBTree.depth(tree)

    assert depth == 1
    assert tree == expected
  end
  test "[1, 3, 2]" do
    input = [1, 3, 2]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTree.new(input) == expected
  end

  test "[2, 1, 3]" do
    input = [2, 1, 3]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTree.new(input) == expected
  end
  test "[2, 3, 1]" do
    input = [2, 3, 1]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTree.new(input) == expected
  end

  test "[3, 2, 1]" do
    input = [3, 2, 1]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTree.new(input) == expected
  end
  test "[3, 1, 2]" do
    input = [3, 1, 2]
    expected = {{nil, 1, nil}, 2, {nil, 3, nil}}
    assert BBTree.new(input) == expected
  end

  test "[1, 2, 3, 4, 5, 6, 7]" do
    input = Enum.shuffle [1, 2, 3, 4, 5, 6, 7]
    expected = {
      {
        {nil, 1, nil},
        2,
        {nil, 3, nil}
      },
      4,
      {
        {nil, 5, nil},
        6,
        {nil, 7, nil}
      }
    }
    assert BBTree.new(input) == expected
  end

  test "1..15" do
    input = 1..15 |> Enum.to_list |> Enum.shuffle
    expected = 3
    tree = input |> BBTree.new
    tree |> inspect |> IO.puts
    assert tree |> BBTree.depth == expected
  end

  test "1..31" do
    input = 1..(:math.pow(2,5)|>round)-1 |> Enum.to_list
    input |> inspect |> IO.puts

    shuffled = input |> Enum.shuffle
    shuffled |> inspect |> IO.puts

    tree = shuffled |> BBTree.new
    tree |> inspect |> IO.puts

    assert BBTree.to_list(tree) == input

    expected = 5
    assert BBTree.depth(tree) == expected
  end

end

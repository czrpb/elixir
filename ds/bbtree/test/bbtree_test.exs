defmodule BBTreeTest do
  use ExUnit.Case
  doctest BBTree

  test "new tree with value 4" do
    tree = BBTree.tree(4)
    assert tree == {nil, {4, 1, 0}, nil}
    assert BBTree.leaf?(tree)
    assert BBTree.value(tree) == 4
    assert BBTree.count(tree) == 1
    assert BBTree.bal(tree) == 0
    assert BBTree.left(tree) == nil
    assert BBTree.right(tree) == nil
  end

  test "tree with value 4 then insert 4" do
    tree1 = 4 |> BBTree.insert(BBTree.tree(4))
    tree2 = 4 |> BBTree.insert(BBTree.insert(4))
    assert tree1 == {nil, {4, 2, 0}, nil}
    assert tree1 == tree2
  end

  test "basic lesser and greater than inserts" do
    root = BBTree.tree(5)
    tree = 4 |> BBTree.insert(root)
    assert tree == {{nil, {4, 1, 0}, nil}, {5, 1, -1}, nil}

    root = BBTree.tree(5)
    tree = 6 |> BBTree.insert(root)
    assert tree == {nil, {5, 1, 1}, {nil, {6, 1, 0}, nil}}
  end
  test "lesser and greater than inserts keep tree balanced" do
    tree = [4, 6] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree == {
      {nil, {4, 1, 0}, nil}, {5, 1, 0}, {nil, {6, 1, 0}, nil}
    }
  end

  test "2 lesser inserts" do
    tree1 = [4, 3] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    tree2 = [3, 4] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree1 == tree2
    assert tree1 == {
      {nil, {3, 1, 0}, nil}, {4, 1, 0}, {nil, {5, 1, 0}, nil}
    }
  end
  test "2 greater inserts" do
    tree1 = [6, 7] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    tree2 = [7, 6] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree1 == tree2
    assert tree1 == {
      {nil, {5, 1, 0}, nil}, {6, 1, 0}, {nil, {7, 1, 0}, nil}
    }
  end

  test "random tree #1: [3, 2, 6, 1, 9]" do
    tree = [3, 2, 6, 1, 9] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree == {
      {{nil, {1, 1, 0}, nil}, {2, 1, -1}, nil},
      {3, 1, 1},
      {{nil, {5, 1, 0}, nil}, {6, 1, 0}, {nil, {9, 1, 0}, nil}}
    }
  end

  test "random tree #2: [2, 8, 5, 1, 6]" do
    tree = [2, 8, 5, 1, 6] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree == {
      {{nil, {1, 1, 0}, nil}, {2, 1, -1}, nil},
      {5, 2, 0},
      {{nil, {6, 1, 0}, nil}, {8, 1, -1}, nil}
    }
  end

  test "random tree #3: [18, 14, 17, 20, 10, 10, 6, 9, 20, 8]" do
#    tree = [18, 14, 17, 20, 10, 10, 6, 9, 20, 8] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    tree = [18, 14, 17, 20, 10, 6, 9, 8] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree == {
      {
        {nil, {5, 1, 0}, nil},
        {6, 1, 2},
        {{nil, {8, 1, 0}, nil}, {9, 1, 0}, {nil, {10, 1, 0}, nil}}
      },
      {14, 1, -2},
      {{nil, {17, 1, 0}, nil}, {18, 1, 0}, {nil, {20, 1, 0}, nil}}
    }
  end

  test "random tree #4: [5, 2, 4, 17, 3, 14, 2, 16, 19, 6]" do
    tree = [5, 2, 4, 17, 3, 14, 2, 16, 19, 6] |> Enum.reduce(BBTree.tree(5), &BBTree.insert/2)
    assert tree == {
      {},
      {},
      {}
    }
  end
end

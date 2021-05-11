defmodule SymmetricTreeTest do
  use ExUnit.Case
  doctest SymmetricTree

  test "root only is symmetric" do
    tree = {nil, :root, nil}
    assert SymmetricTree.tree(tree) == :symmetric
  end

  test "1 level: symmetric" do
    tree = {{nil, :child, nil}, :parent, {nil, :child, nil}}
    assert SymmetricTree.tree(tree) == :symmetric
  end
  test "1 level: not symmetric" do
    tree = {{nil, :leftchild, nil}, :parent, {nil, :rightchild, nil}}
    assert SymmetricTree.tree(tree) == :not_symmetric
  end

  test "leetcode test 1" do
    tree = {
      {
        {nil, 3, nil},
        2,
        {nil, 4, nil}
      },
      1,
      {
        {nil, 4, nil},
        2,
        {nil, 3, nil}
      }
    }
    assert SymmetricTree.tree(tree) == :symmetric
  end
  test "leetcode test 2" do
    tree = {
      {
        nil,
        2,
        {nil, 3, nil}
      },
      1,
      {
        nil,
        2,
        {nil, 3, nil}
      }
    }
    assert SymmetricTree.tree(tree) == :not_symmetric
  end
end

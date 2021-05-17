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

  test "1 level: symmetric (iterative)" do
    tree = {{nil, :child, nil}, :parent, {nil, :child, nil}}
    assert SymmetricTree.tree_iter(tree) == {:ok, :symmetric}
  end

  test "leetcode test 1 (iterative)" do
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
    assert SymmetricTree.tree_iter(tree) == {:ok, :symmetric}
  end
  test "leetcode test 1.1 (iterative)" do
    tree = {
      {
        {nil, 3, nil},
        2,
        {nil, 4, nil}
      },
      1,
      {
        {nil, 5, nil},
        2,
        {nil, 3, nil}
      }
    }
    assert SymmetricTree.tree_iter(tree) == {:ok, :symmetric}
  end

  test "leetcode test 2 (iterative)" do
    tree = {
      {
        nil,
        2,
        {nil, 3.1, nil}
      },
      1,
      {
        nil,
        2,
        {nil, 3.2, nil}
      }
    }
    {:err, :not_symmetric, exception} = SymmetricTree.tree_iter(tree)
    exception|>inspect|>IO.puts
    assert True
  end

  test "deeper tree (iterative)" do
    tree = {
      {
        {
          {
            {nil, 9, nil},
            5,
            {nil, 10, nil}
          },
          3,
          {
            {nil, 11, nil},
            6,
            {nil, 12, nil}
          }
        },
        2,
        {
          {
            {nil, 13, nil},
            7,
            {nil, 14, nil}
          },
          4,
          {
            {nil, 15, nil},
            8,
            {nil, 16, nil}
          }
        }
      },
      1,
      {
        {
          {
            {nil, 16, nil},
            8,
            {nil, 15, nil}
          },
          4,
          {
            {nil, 14, nil},
            7,
            {nil, 13, nil}
          }
        },
        2,
        {
          {
            {nil, 12, nil},
            6,
            {nil, 11, nil}
          },
          3,
          {
            {nil, 10, nil},
            5,
            {nil, 9, nil}
          }
        }
      }
    }
    {:ok, :symmetric} = SymmetricTree.tree_iter(tree)
    assert True
  end

  test "deeper tree but bad (iterative)" do
    tree = {
      {
        {
          {
            {nil, 9, nil},
            5,
            {nil, 10, nil}
          },
          3,
          {
            {nil, 11, {nil, 17, nil}},
            6,
            {nil, 12, nil}
          }
        },
        2,
        {
          {
            {nil, 13, {nil, 18, nil}},
            7,
            {nil, 14, nil}
          },
          4,
          {
            {nil, 15, nil},
            8,
            {nil, 16, nil}
          }
        }
      },
      1,
      {
        {
          {
            {nil, 16, nil},
            8,
            {nil, 15, nil}
          },
          4,
          {
            {nil, 14, nil},
            7,
            {nil, 13, {nil, 18, nil}}
          }
        },
        2,
        {
          {
            {nil, 12, nil},
            6,
            {{nil, 17, nil}, 11, nil}
          },
          3,
          {
            {nil, 10, nil},
            5,
            {nil, 9, nil}
          }
        }
      }
    }
    {:ok, :symmetric} = SymmetricTree.tree_iter(tree)
    assert True
  end

end

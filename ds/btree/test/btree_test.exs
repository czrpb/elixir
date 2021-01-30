defmodule BtreeTest do
  use ExUnit.Case
  doctest BTree

  @million 1000000

  test "a tree is a tree" do
    tree = BTree.new(0)
    refute BTree.tree?(tree)
    assert BTree.leaf?(tree)
  end

  test "a leaf is a leaf" do
    leaf = BTree.leaf(4)
    assert BTree.leaf?(leaf)
    refute BTree.tree?(leaf)
  end

  test "leaf with a value of 4 has a value of 4" do
    leaf = BTree.leaf(4)
    assert BTree.value(leaf) == 4
  end

  test "tree's left leaf is the left leaf" do
    left = BTree.leaf(-1)
    tree = BTree.new(0) |> BTree.left(left)
    left_from_tree = BTree.left(tree)
    assert left == left_from_tree
    assert BTree.value(left) == BTree.value(left_from_tree)
    assert BTree.value(left_from_tree) == -1
  end

  test "tree's right leaf is the right leaf" do
    right = BTree.leaf(1)
    tree = BTree.new(0) |> BTree.right(right)
    right_from_tree = BTree.right(tree)
    assert right == right_from_tree
    assert BTree.value(right) == BTree.value(right_from_tree)
    assert BTree.value(right_from_tree) == 1
  end

  test "insert less is left leaf" do
    tree = BTree.new(0) |> BTree.insert(-1)
    assert BTree.tree?(tree)
    left = BTree.left(tree)
    assert BTree.leaf?(left)
    assert BTree.value(left) == -1
  end

  test "insert more is right leaf" do
    tree = BTree.new(0) |> BTree.insert(1)
    assert BTree.tree?(tree)
    right = BTree.right(tree)
    assert BTree.leaf?(right)
    assert BTree.value(right) == 1
  end

  test "insert -1, -2 should be a left-weighted tree" do
    tree = BTree.new(0)
    |> BTree.insert(-1)
    |> BTree.insert(-2)
    assert tree == {{{nil, -2, nil}, -1, nil}, 0, nil}
  end
  test "insert 1, 2 should be a right-weighted tree" do
    tree = BTree.new(0)
    |> BTree.insert(1)
    |> BTree.insert(2)
    assert tree == {nil, 0, {nil, 1, {nil, 2, nil}}}
  end
  test "insert 1, 2, -1, -2 should be a balanced tree" do
    tree = BTree.new(0)
    |> BTree.insert(1)
    |> BTree.insert(2)
    |> BTree.insert(-1)
    |> BTree.insert(-2)
    assert tree == {{{nil, -2, nil}, -1, nil}, 0, {nil, 1, {nil, 2, nil}}}
  end

  test "insert -2, -1 should be a zig-zag tree" do
    tree = BTree.new(0)
    |> BTree.insert(-2)
    |> BTree.insert(-1)
    assert tree == {{nil, -2, {nil, -1, nil}}, 0, nil}
  end
  test "insert 2, 1 should be a zag-zig tree" do
    tree = BTree.new(0)
    |> BTree.insert(2)
    |> BTree.insert(1)
    assert tree == {nil, 0, {{nil, 1, nil}, 2, nil}}
  end

  test "insert 2, 1, -2, -1 should be a zigzag-zagzig tree" do
    tree = BTree.new(0)
    |> BTree.insert(2)
    |> BTree.insert(1)
    |> BTree.insert(-2)
    |> BTree.insert(-1)
    assert tree == {{nil, -2, {nil, -1, nil}}, 0, {{nil, 1, nil}, 2, nil}}
  end

  test "random tree #1: [3, 2, 6, 1, 9]" do
    tree = [3, 2, 6, 1, 9]
    |> Enum.reduce(
      BTree.new(5),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    assert tree == {{{{nil, 1, nil}, 2, nil}, 3, nil}, 5, {nil, 6, {nil, 9, nil}}}
  end

  test "random tree #2: [2, 8, 5, 1, 6]" do
    tree = [2, 8, 5, 1, 6]
    |> Enum.reduce(
      BTree.new(5),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    assert tree == {{{nil, 1, nil}, 2, nil}, 5, {{nil, 6, nil}, 8, nil}}
  end

  test "random tree #3: [38, 31, 27, 22, 43, 44, 30, 40, 20, 11, 41, 37, 11, 42, 42, 25, 14, 33, 43, 4]" do
    tree = [38, 31, 27, 22, 43, 44, 30, 40, 20, 11, 41, 37, 11, 42, 42, 25, 14,
            33, 43, 4]
    |> Enum.reduce(
      BTree.new(25),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    assert tree == {
      {
        {{{nil, 4, nil}, 11, {nil, 14, nil}}, 20, nil},
        22,
        nil
      },
      25,
      {
        {{nil, 27, {nil, 30, nil}}, 31, {{nil, 33, nil}, 37, nil}},
        38,
        {{nil, 40, {nil, 41, {nil, 42, nil}}}, 43, {nil, 44, nil}}
      }
    }
  end

  test "sorted tree(0): [1, 3, 5]" do
    tree = [1, 3, 5]
    |> Enum.reduce(
      BTree.new(0),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> BTree.sorted
    assert tree == [0, 1, 3, 5]
  end
  test "sorted tree(6): [1, 3, 5]" do
    tree = [1, 3, 5]
    |> Enum.reduce(
      BTree.new(6),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> BTree.sorted
    assert tree == [1, 3, 5, 6]
  end
  test "sorted tree(2): [1, 3, 5]" do
    tree = [1, 3, 5]
    |> Enum.reduce(
      BTree.new(2),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> BTree.sorted
    assert tree == [1, 2, 3, 5]
  end
  test "sorted tree(4): [1, 3, 5]" do
    tree = [1, 3, 5]
    |> Enum.reduce(
      BTree.new(4),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> BTree.sorted
    assert tree == [1, 3, 4, 5]
  end

  test "one thousand random numbers sorted" do
    nums = for _n <- 1..1000, do: :rand.uniform(500)
    root = nums |> Enum.at(500)
    nums = MapSet.new(nums)

    {ms, nums_sorted} = :timer.tc(fn -> Enum.sort(nums) end)

    {mst, tree} = nums
    |> Enum.reduce(
      BTree.new(root),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> (fn tree -> :timer.tc(fn -> BTree.sorted(tree) end) end).()

    assert nums_sorted == tree
    IO.puts("one thousand -> Enum.sort: #{ms/@million}  BTree.sort: #{mst/@million}")
  end
  test "ten thousand random numbers sorted" do
    nums = for _n <- 1..10000, do: :rand.uniform(2000)
    root = nums |> Enum.at(5000)
    nums = MapSet.new(nums)

    {ms, nums_sorted} = :timer.tc(fn -> Enum.sort(nums) end)

    {mst, tree} = nums
    |> Enum.reduce(
      BTree.new(root),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> (fn tree -> :timer.tc(fn -> BTree.sorted(tree) end) end).()

    assert nums_sorted == tree
    IO.puts("ten thousand -> Enum.sort: #{ms/@million}  BTree.sort: #{mst/@million}")
  end
  test "million random numbers sorted" do
    nums = for _n <- 1..@million, do: :rand.uniform(200000)
    root = nums |> Enum.at(500000)
    nums = MapSet.new(nums)

    {ms, nums_sorted} = :timer.tc(fn -> Enum.sort(nums) end)

    {mst, tree} = nums
    |> Enum.reduce(
      BTree.new(root),
      fn n, tree ->
        BTree.insert(tree, n)
      end
    )
    |> (fn tree -> :timer.tc(fn -> BTree.sorted(tree) end) end).()
    assert nums_sorted == tree
    IO.puts("million -> Enum.sort: #{ms/@million}  BTree.sort: #{mst/@million}")
  end

  @tag timeout: :infinity
  test "fifty million random numbers sorted" do
    {ms_build, {nums, root}} = :timer.tc(
      fn ->
        nums = for _n <- 1..50000000, do: :rand.uniform(50000000)
        root = nums |> Enum.at(5000000)
        nums = MapSet.new(nums)
        {nums, root}
      end
    )

    {ms, nums_sorted} = :timer.tc(fn -> Enum.sort(nums) end)

    IO.puts("fifty million -> Enum.sort: #{(ms+ms_build)/@million} [#{ms/@million} #{ms_build/@million}]")

    {mst_build, tree} = :timer.tc(
      fn ->
        nums
        |> Enum.reduce(
          BTree.new(root),
          fn n, tree ->
            BTree.insert(tree, n)
          end
        )
      end
    )
    {mst, tree_sorted} = :timer.tc(fn -> BTree.sorted(tree) end)

    IO.puts("BTree.sorted: #{(mst+mst_build)/@million} [#{mst/@million} #{mst_build/@million}]")

    {mst_task, tree_sorted_with_tasks} = :timer.tc(fn -> BTree.sorted_with_tasks(tree) end)

    IO.puts("BTree.sorted_with_tasks: #{(mst_build+mst_task)/@million} [#{mst_task/@million}]")

    assert nums_sorted == tree_sorted
    assert tree_sorted == tree_sorted_with_tasks
  end

  test "rebuilt input order" do
    input = [3, 2, 6, 1, 9]
    tree = input
    |> Enum.reduce(BTree.new(5), &(BTree.insert(&2, &1)))
    output = tree |> BTree.inserted
    assert [5|input] == output
  end
end

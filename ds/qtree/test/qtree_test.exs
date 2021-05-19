defmodule QTreeTest do
  use ExUnit.Case
  doctest QTree

  @million 1000000
  @thousand 1000

  test "new tree from value" do
    tree = QTree.tree(4)
    assert tree == {nil, [4], nil}
  end
  test "new tree from data" do
    tree = QTree.tree([1, 2])
    assert tree == {nil, [1, 2], nil}
  end

  test "insert [3, 9, 7]" do
    tree = QTree.tree(3)
    assert tree == {nil, [3], nil}
    tree = 9 |> QTree.insert(tree)
    assert tree == {nil, [3, 9], nil}
    tree = 7 |> QTree.insert(tree)
    assert tree == {{nil, [3], nil}, [7], {nil, [9], nil}}
  end

  test "insert [3, 9, 7, 10, 8]" do
    tree = [9, 7] |> Enum.reduce(QTree.tree(3), &QTree.insert/2)
    assert tree == {{nil, [3], nil}, [7], {nil, [9], nil}}
    tree = 10 |> QTree.insert(tree)
    assert tree == {{nil, [3], nil}, [7], {nil, [9, 10], nil}}
    tree = 8 |> QTree.insert(tree)
    assert tree == {{nil, [3], nil}, [7, 8], {nil, [9, 10], nil}}
  end

  test "insert [6, 8, 7, 11, 10, 9]" do
    nums = [6, 8, 7, 11, 10, 9]
    [root|rest] = nums
    tree = rest |> Enum.reduce(QTree.tree(root), &QTree.insert/2)
    assert tree == {
      {nil, [6], nil},
      [7],
      {{nil, [8], nil}, [9, 10], {nil, [11], nil}}
    }
  end

  test "insert [1, 17, 11, 15, 9]" do
    tree = [17, 11] |> Enum.reduce(QTree.tree(1), &QTree.insert/2)
    assert tree == {{nil, [1], nil}, [11], {nil, [17], nil}}
    tree = 15 |> QTree.insert(tree)
    assert tree == {{nil, [1], nil}, [11, 15], {nil, [17], nil}}
    tree = 9 |> QTree.insert(tree)
    assert tree == {{nil, [1], nil}, [9, 11, 15], {nil, [17], nil}}
  end

  test "insert [2, 14, 15, 11, 20]" do
    tree = [14, 15] |> Enum.reduce(QTree.tree(2), &QTree.insert/2)
    assert tree == {nil, [2, 14, 15], nil}
    tree = 11 |> QTree.insert(tree)
    assert tree == {{nil, [2], nil}, [11], {nil, [14, 15], nil}}
    tree = 9 |> QTree.insert(tree)
    assert tree == {{nil, [2], nil}, [9, 11], {nil, [14, 15], nil}}
  end

  test "insert [18, 10, 19, 3, 11]" do
    tree = [10, 19] |> Enum.reduce(QTree.tree(18), &QTree.insert/2)
    assert tree == {nil, [10, 18, 19], nil}
    tree = 3 |> QTree.insert(tree)
    assert tree == {nil, [3, 10, 18, 19], nil}
    tree = 11 |> QTree.insert(tree)
    assert tree == {{nil, [3, 10], nil}, [11], {nil, [18, 19], nil}}
  end

  test "insert [11, 16, 20, 15, 1]" do
    tree = [16, 20] |> Enum.reduce(QTree.tree(11), &QTree.insert/2)
    assert tree == {nil, [11, 16, 20], nil}
    tree = 15 |> QTree.insert(tree)
    assert tree == {{nil, [11], nil}, [15], {nil, [16, 20], nil}}
    tree = 1 |> QTree.insert(tree)
    assert tree == {{nil, [1, 11], nil}, [15], {nil, [16, 20], nil}}
  end

  test "insert [18, 6, 10, 12, 20]" do
    tree = QTree.tree(18)
    assert tree == {nil, [18], nil}
    tree = 6 |>  QTree.insert(tree)
    assert tree == {nil, [6, 18], nil}
    tree = 10 |> QTree.insert(tree)
    assert tree == {{nil, [6], nil}, [10], {nil, [18], nil}}
    tree = 12 |> QTree.insert(tree)
    assert tree == {{nil, [6], nil}, [10, 12], {nil, [18], nil}}
    tree = 20 |> QTree.insert(tree)
    assert tree == {{nil, [6], nil}, [10, 12], {nil, [18, 20], nil}}
  end

  test "insert [18, 12, 4, 5, 7, 19, 8, 10, 9, 15, 16]" do
    tree = QTree.tree(18)
    assert tree == {nil, [18], nil}
    tree = 12 |>  QTree.insert(tree)
    assert tree == {nil, [12, 18], nil}
    tree = 4 |>  QTree.insert(tree)
    assert tree == {nil, [4, 12, 18], nil}
    tree = 5 |>  QTree.insert(tree)
    assert tree == {{nil, [4], nil}, [5], {nil, [12, 18], nil}}
    tree = 7 |>  QTree.insert(tree)
    assert tree == {{nil, [4], nil}, [5, 7], {nil, [12, 18], nil}}
    tree = 19 |>  QTree.insert(tree)
    assert tree == {{nil, [4], nil}, [5, 7], {nil, [12, 18, 19], nil}}
    tree = 8 |>  QTree.insert(tree)
    assert tree == {{nil, [4], nil}, [5, 7, 8], {nil, [12, 18, 19], nil}}
    tree = 10 |>  QTree.insert(tree)
    assert tree == {{nil, [4], nil}, [5, 7, 8, 10], {nil, [12, 18, 19], nil}}
    tree = 9 |>  QTree.insert(tree)
    assert tree == {
      {{nil, [4], nil}, [5, 7, 8], nil},
      [9],
      {nil, [10], {nil, [12, 18, 19], nil}}
    }
    tree = 15 |>  QTree.insert(tree)
    assert tree == {
      {{nil, [4], nil}, [5, 7, 8], nil},
      [9],
      {
        nil,
        [10],
        {{nil, [12], nil}, [15], {nil, [18, 19], nil}}
      }
    }
    tree = 16 |>  QTree.insert(tree)
    assert tree == {
      {{nil, [4], nil}, [5, 7, 8], nil},
      [9],
      {
        nil,
        [10],
        {{nil, [12], nil}, [15, 16], {nil, [18, 19], nil}}
      }
    }
  end

  test "sorted [18, 12, 4, 5, 7, 19, 8, 10, 9, 15, 16]" do
    list = [18, 12, 4, 5, 7, 19, 8, 10, 9, 15, 16]
    [root|remainder] = list
    tree = remainder
    |> Enum.reduce(QTree.tree(root), &QTree.insert/2)
    assert QTree.sorted(tree) == Enum.sort(list)
  end

  test "sorted list of [almost] #{div(@thousand, 50)} nums" do
    nums = 0..div(@thousand, 50)
    |> Enum.into(MapSet.new(), fn _ -> :rand.uniform(@thousand*5) end)
    |> Enum.shuffle
    {ms_nums, nums_sorted} = :timer.tc(fn -> Enum.sort(nums) end)
    IO.puts("Sorting #{Enum.count(nums)} nums took #{ms_nums/@million}secs")
    [root|rest] = nums
    {ms_tree, tree} = :timer.tc(fn ->
      rest |> Enum.reduce(QTree.tree(root), &QTree.insert/2)
    end)
    IO.puts("Building QTree took #{ms_tree/@million}secs")
    {ms_tree_sorted, tree_sorted} = :timer.tc(fn ->
      QTree.sorted(tree)
    end)
    IO.puts("Returning QTree took #{ms_tree_sorted/@million}secs")
    if nums_sorted != tree_sorted do
      IO.puts("Original list: #{Enum.join(nums, ", ")}")
    end
    assert nums_sorted == tree_sorted
  end

  test "sorted [1964, 4756, 1352, 1740, 1872, 1127, 4293, 2389, 2827, 2613]" do
    [root|nums] = [1964, 4756, 1352, 1740, 1872, 1127, 4293, 2389]#, 2827, 2613]
    nums_sorted = Enum.sort(nums)
    tree = nums |> Enum.reduce(QTree.tree(root), &QTree.insert/2)
    assert tree == {
      {nil, [1127, 1352], nil},
      [1740, 1872],
      {{nil, [1964, 2389], nil}, [4293], {nil, [4756], nil}}
    }
    tree_sorted = QTree.sorted(tree)
    assert nums_sorted == tree_sorted
  end
  test "sorted [3058, 589, 1135, 1938, 4773, 4447, 4267, 2339, 2863, 4450, 647]" do
    [root|nums] = [3058, 589, 1135, 1938, 4773, 4447, 4267, 2339, 2863, 4450, 647]
    nums_sorted = Enum.sort(nums)
    tree = nums |> Enum.reduce(QTree.tree(root), &QTree.insert/2)
    tree_sorted = QTree.sorted(tree)
    assert nums_sorted == tree_sorted
  end
end

defmodule BTree do
  @moduledoc """
  Documentation for `Btree`.
  """

  # Utility functions
  def new(root) do
    leaf(root)
  end
  def leaf(value) do
    {nil, value, nil}
  end
  def tree?(tree) do
    not leaf?(tree)
  end
  def leaf?(node) do
    try do
      {nil, _value, nil} = node
      true
    rescue
      MatchError -> false
    end
  end

  def value(node) do
    {_, value, _} = node
    value
  end

  # Functions to mess with the left or right nodes
  def left({left, _value, _right}) do
    left
  end
  def left({_, value, right}, newleft) do
    {newleft, value, right}
  end

  def right({_left, _value, right}) do
    right
  end
  def right({left, value, _}, newright) do
    {left, value, newright}
  end

  # Heads to insert on the left
  def insert({nil, value, right}, newvalue)
    when newvalue < value
    do
    {leaf(newvalue), value, right}
  end
  def insert({left, value, right}, newvalue)
    when newvalue < value
    do
    {insert(left, newvalue), value, right}
  end

  # Heads to insert on the right
  def insert({left, value, nil}, newvalue)
    when value < newvalue
    do
    {left, value, leaf(newvalue)}
  end
  def insert({left, value, right}, newvalue)
    when value < newvalue
    do
    {left, value, insert(right, newvalue)}
  end

  # Sorted tree to sorted list
  def sorted({nil, value, nil}), do: [value]
  def sorted({left, value, nil}), do: sorted(left) ++ [value]
  def sorted({nil, value, right}), do: [value] ++ sorted(right)
  def sorted({left, value, right}), do: sorted(left) ++ [value] ++ sorted(right)

  def sorted_with_tasks(tree) do
    case tree do
      {nil, value, nil} -> [value]
      {left, value, nil} ->
        left_task = Task.async(fn -> sorted(left) end)
        Task.await(left_task, :infinity) ++ [value]
      {nil, value, right} ->
        right_task = Task.async(fn -> sorted(right) end)
        [value] ++ Task.await(right_task, :infinity)
      {left, value, right} ->
        left_task = Task.async(fn -> sorted(left) end)
        right_task = Task.async(fn -> sorted(right) end)
        Task.await(left_task, :infinity) ++ [value] ++ Task.await(right_task, :infinity)
    end
  end

end

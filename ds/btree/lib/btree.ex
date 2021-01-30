defmodule BTree do
  @moduledoc """
  Documentation for `Btree`.
  """

  @doc """
  """
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

  def left(node) do
    {left, _value, _right} = node
    left
  end
  def left(node, newleft) do
    {_, value, right} = node
    {newleft, value, right}
  end

  def right(node) do
    {_left, _value, right} = node
    right
  end
  def right(node, newright) do
    {left, value, _} = node
    {left, value, newright}
  end

  def insert(tree, newvalue) do
    {left, value, right} = tree
    cond do
      newvalue < value ->
        if left == nil do
          {leaf(newvalue), value, right}
        else
          {insert(left, newvalue), value, right}
        end
      newvalue > value ->
        if right == nil do
          {left, value, leaf(newvalue)}
        else
          {left, value, insert(right, newvalue)}
        end
      true ->
        tree
    end
  end

  def inserted(tree) do
    case tree do
      {nil, value, nil} -> [value]
      {left, value, nil} ->
        [value] ++ sorted(left)
      {nil, value, right} ->
        [value] ++ sorted(right)
      {left, value, right} ->
        [value] ++ sorted(left) ++ sorted(right)
    end
  end

  def sorted(tree) do
    case tree do
      {nil, value, nil} -> [value]
      {left, value, nil} -> sorted(left) ++ [value]
      {nil, value, right} -> [value] ++ sorted(right)
      {left, value, right} -> sorted(left) ++ [value] ++ sorted(right)
    end
  end

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

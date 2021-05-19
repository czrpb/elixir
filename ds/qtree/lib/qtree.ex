defmodule QTree do
  @moduledoc """
  Documentation for `QTree`.
  """

  def tree(data) when is_list(data) do
    {nil, data, nil}
  end
  def tree(value) do
    {nil, [value], nil}
  end
  def leaf?(tree) do
    {left, _data, right} = tree
    left == nil and right == nil
  end

  def left(tree) do
    {left, _data, _right} = tree
    left
  end
  def right(tree) do
    {_left, _data, right} = tree
    right
  end

  def peek(tree, side) do
    {_, data, _} = tree
    case side do
      :left -> List.last(data)
      :right -> List.first(data)
    end
  end

  def insert(value, tree \\ nil) do
    if tree == nil do
      tree(value)
    else
      {left, data, right} = tree
      {smallest, largest} = {List.first(data), List.last(data)}
      cond do
        right == nil and largest < value ->
          {left, data ++ [value], right}

        left == nil and value < smallest ->
          {left, [value|data], right}

        smallest < value and value < largest ->
          {smaller, larger} = data |> Enum.split_while(&(&1<value))
          {{left, smaller, nil}, [value], {nil, larger, right}}

        value < smallest ->
          if peek(left, :left) < value do
            {left, [value|data], right}
          else
            {insert(value, left), data, right}
          end

        largest < value ->
          if value < peek(right, :right) do
            {left, data ++ [value], right}
          else
            {left, data, insert(value, right)}
          end

      end
    end
  end

  def sorted(nil) do
    []
  end
  def sorted(tree) do
    {left, data, right} = tree
    sorted(left) ++ data ++ sorted(right)
  end

end

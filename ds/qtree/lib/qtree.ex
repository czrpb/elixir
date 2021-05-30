defmodule QTree do
  @moduledoc """
  Documentation for `QTree`.
  """

  # Heads to create a tree
  def tree(data) when is_list(data) do
    {min, data} = Enum.sort(data) |> List.pop_at(0)
    {max, data} = List.pop_at(data, -1)
    {nil, {min, data, max}, nil}
  end
  def tree(newvalue) do
    {nil, {nil, [newvalue], nil}, nil}
  end

  def leaf?({nil, _data, nil}) do
    true
  end

  # Heads to get left/right subtrees
  def left({left, _data, _right}), do: left
  def right({_left, _data, right}), do: right

  # Head to peek into a subtree's value
  def peek({_, {min, _data, _max}, _}, :left), do: min
  def peek({_, {_min, _data, max}, _}, :right), do: max


  ### Head to insert a value into a tree
  def insert(newvalue, nil), do: tree(newvalue)

  # Heads when the tree has just 1 value
  def insert(newvalue, {left, {nil, [num], nil}, right})
  when newvalue < num
  do
    {left, {newvalue, [], num}, right}
  end
  def insert(newvalue, {left, {nil, [num], nil}, right})
  when num < newvalue
  do
    {left, {num, [], newvalue}, right}
  end

  # Heads when the tree has just 2 values
  def insert(newvalue, {left, {min, [], max}, right})
  when newvalue < min
  do
    {left, {newvalue, [min], max}, right}
  end
  def insert(newvalue, {left, {min, [], max}, right})
  when max < newvalue
  do
    {left, {min, [max], newvalue}, right}
  end
  def insert(newvalue, {left, {min, [], max}, right})
  when min < newvalue and newvalue < max
  do
    {left, {min, [newvalue], max}, right}
  end

  # Heads when the tree has just 3 values
  def insert(newvalue, {left, node={min, [_num], _max}, right})
  when newvalue < min
  do
    {insert(newvalue, left), node, right}
  end
  def insert(newvalue, {left, node={_min, [_num], max}, right})
  when max < newvalue
  do
    {left, node, insert(newvalue, right)}
  end
  def insert(newvalue, {left, {min, [num], max}, right})
  when min < newvalue and newvalue < num
  do
    {left, {min, [newvalue, num], max}, right}
  end
  def insert(newvalue, {left, {min, [num], max}, right})
  when num < newvalue and newvalue < max
  do
    {left, {min, [num, newvalue], max}, right}
  end

  # Head for when the newvalue is in data somewhere
  def insert(newvalue, {left, node={min, _data, _max}, right})
  when newvalue < min
  do
    {insert(newvalue, left), node, right}
  end
  def insert(newvalue, {left, node={_min, _data, max}, right})
  when max < newvalue
  do
    {left, node, insert(newvalue, right)}
  end
  def insert(newvalue, {left, {min, data, max}, right})
  when min < newvalue and newvalue < max
  do
    first = List.first(data)
    last = List.last(data)
    cond do
      newvalue < first -> {left, {min, [newvalue|data], max}, right}
      last < newvalue -> {left, {min, data++[newvalue], max}, right}
      true ->
        {smaller, larger} = data |> Enum.split_while(&(&1<newvalue))
        {largest_smaller, smaller} = List.pop_at(smaller, -1)
        [smallest_larger| larger] = larger
        {
          [min|smaller] |> Enum.reduce(left, &insert/2),
          {largest_smaller, [newvalue], smallest_larger},
          larger++[max] |> Enum.reduce(right, &insert/2)
        }
    end
  end


  def sorted(nil) do
    []
  end
  def sorted({left, {nil, data, nil}, right}) do
    sorted(left) ++ data ++ sorted(right)
  end
  def sorted({left, {min, data, max}, right}) do
    sorted(left) ++ [min] ++ data ++ [max] ++ sorted(right)
  end

end

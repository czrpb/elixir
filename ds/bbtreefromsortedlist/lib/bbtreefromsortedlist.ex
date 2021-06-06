defmodule BBTreeFromSortedList do
  @moduledoc """
  Documentation for `BBTreeFromSortedList`.
  """

  def treenode(value), do: {nil, value, nil}

  def insert(newvalue, nil), do: treenode(newvalue)

  def insert(newvalue, {left, value, right})
  when newvalue < value
  do
    {insert(newvalue, left), value, right}
  end

  def insert(newvalue, {left, value, right})
  when newvalue > value
  do
    {left, value, insert(newvalue, right)}
  end

  def new(values) do
    [root|values] = values
    values |> Enum.reduce(treenode(root), &insert/2)
  end

  def from_sorted([]), do: nil
  def from_sorted(values) do
    {lvalues, [root|rvalues]} = values
    |> Enum.split(div(Enum.count(values), 2))

    {from_sorted(lvalues), root, from_sorted(rvalues)}


    # Enum.zip(Enum.reverse(lvalues), rvalues)
    # |> Enum.flat_map(&Tuple.to_list/1)
    # |> (fn l -> [root|l] end).()
    # |> new
  end
end

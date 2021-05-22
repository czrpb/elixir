defmodule TreeInsertBF do
  @moduledoc """
  Documentation for `TreeInsertBF`.
  """

  defp mknode(value) do
    {nil, value, nil}
  end

  defp insert_left({nil, value, right}, value_to_insert) do
    {mknode(value_to_insert), value, right}
  end
  defp insert_left({left, value, nil}, value_to_insert) do
    {left, value, mknode(value_to_insert)}
  end
  defp insert_left({left, value, right}, value_to_insert) do
    {insert_left(left, value_to_insert), value, right}
  end

  def insert_left_into_tree(root, nodes) do
    nodes
    |> Enum.reduce(mknode(root), &insert_left(&2, &1))
  end

  defp mknode2(value) do
    {{nil, value, nil}, {0, 0}}
  end

  defp insert_bf(nil, new_value) do
    mknode2(new_value)
  end
  defp insert_bf({{left, value, right}, {lcnt, rcnt}}, new_value)
    when lcnt == rcnt do
    {{insert_bf(left, new_value), value, right}, {lcnt+1, rcnt}}
  end
  defp insert_bf({{left, value, right}, {lcnt, rcnt}}, new_value)
    when lcnt > rcnt do
    {{left, value, insert_bf(right, new_value)}, {lcnt, rcnt+1}}
  end
  def insert_bf_into_tree(root, values) do
    values
    |> Enum.reduce(mknode2(root), &insert_bf(&2, &1))
  end
end

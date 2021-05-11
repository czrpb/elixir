defmodule MaximumDepthOfBinaryTree do
  @moduledoc """
  Documentation for `MaximumDepthOfBinaryTree`.
  """

  def hello do
    :world
  end

  defp _depth_rec(nil) do
    0
  end
  defp _depth_rec({left, _value, right}) do
    leftdepth = _depth_rec(left)
    rightdepth = _depth_rec(right)

    max(leftdepth, rightdepth) + 1
  end
  def depth_via_recursion(tree) do
    _depth_rec(tree)
  end


  defp _depth_iter(nodes, count \\ 0)
  defp _depth_iter([], count) do
    count
  end
  defp _depth_iter(nodes, count) do
    subtrees = nodes
    |> Enum.flat_map(
      fn tree ->
        case tree do
          {nil, _, nil}    -> []
          {nil, _, right}  -> [right]
          {left, _, nil}   -> [left]
          {left, _, right} -> [left, right]
        end
      end
    )
    _depth_iter(subtrees, count+1)
  end
  def depth_via_iteration(tree) do
    if tree == nil do
      _depth_iter([])
    else
      _depth_iter([tree])
    end
  end
end

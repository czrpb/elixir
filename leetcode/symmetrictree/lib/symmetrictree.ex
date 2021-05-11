defmodule SymmetricTree do
  @moduledoc """
  Documentation for `SymmetricTree`.
  """

  defp to_list(nil) do
    []
  end

  defp to_list({left, value, right}) do
    to_list(left) ++ [value] ++ to_list(right)
  end

  def tree({lefttree, root, righttree}) do
    left = to_list(lefttree)
    right = to_list(righttree) |> Enum.reverse

    if left == right do
      :symmetric
    else
      :not_symmetric
    end
  end
end

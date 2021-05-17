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

  def tree({lefttree, _root, righttree}) do
    left = to_list(lefttree)
    right = to_list(righttree) |> Enum.reverse

    if left == right do
      :symmetric
    else
      :not_symmetric
    end
  end

  defp tree_iter_({[], []}) do
    {:ok, :symmetric}
  end
  defp tree_iter_({lefts, rights}) do
    #IO.puts("#{lefts|>inspect} | #{rights|>inspect}")
    if Enum.count(lefts) != Enum.count(rights) do
      {:err, :not_symmetric, "differing subtree size"}
    else
      [lefts, rights]
      |> Enum.zip
      |> Enum.reduce(
        {[], []},
        fn
          {nil, nil}, acc -> acc
          {{ll, v, lr}, {rl, v, rr}}, {new_lefts, new_rights} ->
            {[lr, ll|new_lefts], [rl, rr|new_rights]}
        end
      )
      |> tree_iter_
    end
  end
  def tree_iter(root) do
    if root == nil do
      {:ok, :symmetric}
    else
      #try do
        {{ll, v, lr}, _, {rl, v, rr}} = root
        tree_iter_({[lr, ll], [rl, rr]})
      #rescue
      #  err -> {:err, :not_symmetric, err}
      #end
    end
  end
end

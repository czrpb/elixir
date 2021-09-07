defmodule FlattenArray do
  @moduledoc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten(list), do: flatten(list, [], :reverse)


  def flatten([], result, :no_reverse), do: result
  def flatten([], result, :reverse), do: result |> Enum.reverse

  def flatten([nil|t], result, do_reverse), do: flatten(t, result, do_reverse)
  def flatten([[]|t], result, do_reverse), do: flatten(t, result, do_reverse)
  def flatten([h|t], result, do_reverse)
  when is_list(h) do
    flatten(t, flatten(h, result, :no_reverse), do_reverse)
  end
  def flatten([h|t], result, do_reverse), do: flatten(t, [h|result], do_reverse)
end

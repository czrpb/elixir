defmodule BinarySearch do
  @moduledoc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found

  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers)-1)

  def search(_, _, low, high)
  when low > high do
    :not_found
  end

  def search(numbers, key, low, high) do
    i = low + ((high-low)/2 |> round)
    mid = elem(numbers, i)

    cond do
      mid == key -> {:ok, i}
      mid < key -> search(numbers, key, i+1, high)
      mid > key -> search(numbers, key, low, i-1)
    end
  end
end

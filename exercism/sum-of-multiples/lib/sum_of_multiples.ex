defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer

  def to(1, _), do: 0

  def to(limit, factors) do
    factors = Enum.filter(factors, & &1!=0)

    1..(limit - 1)
    |> Enum.filter(fn
      n ->
        factors |> Enum.filter(&(rem(n, &1) == 0)) |> Enum.any?()
    end)
    |> Enum.sum()
  end
end

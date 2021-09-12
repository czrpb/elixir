defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}

  def classify(number)
      when number <= 0 do
    {:error, "Classification is only possible for natural numbers."}
  end

  def classify(1), do: {:ok, :deficient}
  def classify(2), do: {:ok, :deficient}

  def classify(number) do
    sum_of_factors = 1 + (factors(number) |> Enum.sum())

    {:ok,
     cond do
       sum_of_factors < number -> :deficient
       sum_of_factors > number -> :abundant
       true -> :perfect
     end}
  end

  def factors(number) do
    2..((number / 2) |> floor)
    |> Enum.filter(&(rem(number, &1) == 0))
  end
end

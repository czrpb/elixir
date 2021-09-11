defmodule PrimeFactors do
  @moduledoc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """

  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    find_factors(number)
  end

  def find_factors(number, factor \\ 2, factors \\ [])

  def find_factors(1, _, factors), do: factors |> Enum.reverse
  def find_factors(number, factor, factors)
  when rem(number, factor) == 0 do
    find_factors(div(number, factor), factor, [factor|factors])
  end
  def find_factors(number, factor, factors), do: find_factors(number, factor+1, factors)
end

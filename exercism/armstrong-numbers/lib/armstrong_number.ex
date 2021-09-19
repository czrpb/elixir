defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    count = Enum.count(digits)
    number == digits |> Enum.map(&:math.pow(&1, count)) |> Enum.sum()
  end
end

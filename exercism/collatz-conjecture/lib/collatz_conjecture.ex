defmodule CollatzConjecture do
  @moduledoc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(1, steps \\ 0), do: steps
  def calc(input, steps)
  when is_integer(input) and 1 < input do
    case rem(input, 2) do
      0 -> calc(div(input, 2), steps+1)
      1 -> calc(input*3+1, steps+1)
    end
  end
end

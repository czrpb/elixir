defmodule SplitBalancedStrings do
  @moduledoc """
  Documentation for `Splitbalancedstrings`.
  """

  def countbalanced(input) do
    {0, result} = input
    |> String.graphemes
    |> Enum.reduce(
      {0, 0},
      fn
        c, {balance, count} ->
          balance = case c do
            "L" -> balance-1
            "R" -> balance+1
          end
          if balance == 0 do
            {0,count+1}
          else
            {balance, count}
          end
      end
    )
    result
  end
end

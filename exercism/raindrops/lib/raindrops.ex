defmodule Raindrops do
  @moduledoc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @factor_string [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}]

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    return = @factor_string
    |> Enum.reduce("", fn
      {f, s}, acc -> acc <> if rem(number, f) == 0, do: s, else: ""
    end)

    if return != "", do: return, else: "#{number}"
  end
end

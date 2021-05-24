defmodule Hexadecimal do
  @moduledoc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @hexvals %{
    "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4,
    "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9,
    "a" => 10, "b" => 11, "c" => 12, "d" => 13,
    "e" => 14, "f" => 15
  }

  defp _to_decimal(hex) do
    hex
    |> String.downcase
    |> String.split("", trim: true)
    |> Enum.map(&(@hexvals[&1]))
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(fn {num, i} -> num * round(:math.pow(16, i)) end)
    |> Enum.sum
  end

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    try do
      _to_decimal(hex)
    rescue
      _ -> 0
    end
  end
end

defmodule Hexadecimal2 do
  def to_decimal(hex) do
    String.graphemes(hex)
    |> Enum.reduce_while(0, &hex_to_decimal(&1, &2))
  end

  def hex_to_decimal(value, acc) do
    case value do
      "0" -> {:cont, 16 * acc + 0}
      "1" -> {:cont, 16 * acc + 1}
      "2" -> {:cont, 16 * acc + 2}
      "3" -> {:cont, 16 * acc + 3}
      "4" -> {:cont, 16 * acc + 4}
      "5" -> {:cont, 16 * acc + 5}
      "6" -> {:cont, 16 * acc + 6}
      "7" -> {:cont, 16 * acc + 7}
      "8" -> {:cont, 16 * acc + 8}
      "9" -> {:cont, 16 * acc + 9}
      "a" -> {:cont, 16 * acc + 10}
      "A" -> {:cont, 16 * acc + 10}
      "b" -> {:cont, 16 * acc + 11}
      "B" -> {:cont, 16 * acc + 11}
      "c" -> {:cont, 16 * acc + 12}
      "C" -> {:cont, 16 * acc + 12}
      "d" -> {:cont, 16 * acc + 13}
      "D" -> {:cont, 16 * acc + 13}
      "e" -> {:cont, 16 * acc + 14}
      "E" -> {:cont, 16 * acc + 14}
      "f" -> {:cont, 16 * acc + 15}
      "F" -> {:cont, 16 * acc + 15}
      _ -> {:halt, 0}
    end
  end
end

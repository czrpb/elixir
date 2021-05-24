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

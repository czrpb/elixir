defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  defp rot(chr, by, lower, upper) do
    rotted = chr + by
    cond do
      upper < rotted -> lower + rem(rotted-lower, 26)
      true -> rotted
    end
  end
  defp rot(char, by) do
    cond do
      # lower char
      ?a <= char and char <= ?z -> rot(char, by, ?a, ?z)

      # upper char
      ?A <= char and char <= ?Z -> rot(char, by, ?A, ?Z)

      # not a letter, not rotated
      true -> char
    end
  end

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(&rot(&1, shift))
    |> to_string
  end
end

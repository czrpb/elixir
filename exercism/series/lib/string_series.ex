defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())

  def slices(_s, size)
      when size < 1 do
    []
  end

  def slices(s, size) do
    slices(String.to_charlist(s), size, [])
  end

  def slices(s, size, substrings)
      when length(s) < size do
    substrings |> Enum.map(&List.to_string/1) |> Enum.reverse()
  end

  def slices([_ | tail] = s, size, substrings) do
    slices(tail, size, [Enum.take(s, size) | substrings])
  end
end

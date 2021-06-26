defmodule RunLengthEncoder do
  # Fantastic solution from:
  ### https://exercism.io/tracks/elixir/exercises/run-length-encoding/solutions/493021c671694de091372066819f61e2
  def encode(""), do: ""
  def encode(string) do
    string
    |> String.graphemes
    |> Enum.chunk_by(&(&1))
    |> Enum.reduce("", fn
      [c], acc ->
        "#{acc}#{c}"
      chars, acc ->
        "#{acc}#{length(chars)}#{hd(chars)}"
    end)
  end

  def decode(""), do: ""
  def decode(string) do
    Regex.scan(~r<(?:(\d*)([a-z\sA-z]))>, string, capture: :all_but_first)
    |> Enum.reduce(
      "",
      fn
        [], acc ->
          "#{acc}"
        [digit_str, char], acc ->
          digit = if digit_str == "", do: 1, else: String.to_integer(digit_str)
          "#{acc}#{String.duplicate(char, digit)}"
      end
    )
  end
end

defmodule RunLengthEncoder_First do
  @moduledoc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """

  @spec _encode(List.t(), List.t()) :: String.t()
  defp _encode([], encoded) do
    encoded
    |> Enum.chunk_every(2)
    |> Enum.reduce("", fn
      [c, 1], acc -> "#{<<c>>}#{acc}"
      [c, n], acc -> "#{n}#{<<c>>}#{acc}"
    end)
  end

  defp _encode([a|tail], []), do:
    _encode(tail, [a, 1])
  defp _encode([a|tail], [a,n|rest]), do:
    _encode(tail, [a, n+1|rest])
  defp _encode([b|tail], [a,n|rest]), do:
    _encode(tail, [b, 1, a, n|rest])

  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.to_charlist
    |> _encode([])
  end


  defp _decode([], _, decoded) do
    decoded
    |> Enum.reduce("", fn
      {1, c}, acc ->
        "#{<<c>>}#{acc}"
      {n, c}, acc ->
        "#{String.duplicate(<<c>>, n)}#{acc}"
    end)
  end

  defp _decode([c|tail], nums, decoded)
  when ?1 <= c and c <= ?9 do
    _decode(tail, [c|nums], decoded)
  end

  defp _decode([c|tail], [], decoded)
  when
    (?a <= c and c <= ?z) or (?A <= c and c <= ?Z)
  do
    _decode(tail, [], [{1, c}|decoded])
  end
  defp _decode([c|tail], nums, decoded)
  when
    (?a <= c and c <= ?z) or (?A <= c and c <= ?Z)
  do
    num = nums |> Enum.reverse |> List.to_string |> String.to_integer
    _decode(tail, [], [{num, c}|decoded])
  end

  defp _decode([c|tail], nums, decoded) do
    nums = nums |> Enum.map(fn _ -> {1, 32} end)
    _decode(tail, [], [{1, c}] ++ nums ++ decoded)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.to_charlist
    |> _decode([], [])
  end
end

defmodule LongestSubstrwoRepeats do
  @moduledoc """
  Documentation for `Longestsubstrworepeats`.
  """

  defp finduniqueprefix(s, substr \\ MapSet.new())
  defp finduniqueprefix([], substr) do
    substr
  end
  defp finduniqueprefix([c|cs], substr) do
    if c in substr do
      substr
    else
      finduniqueprefix(cs, MapSet.put(substr, c))
    end
  end


  defp _longestsubstr(string, substrs \\ MapSet.new([MapSet.new()]))
  defp _longestsubstr([], substrs) do
    longest = substrs |> Enum.max
    longest |> Enum.count
  end
  defp _longestsubstr([c|cs]=s, substrs) do
    _longestsubstr(cs, MapSet.put(substrs, finduniqueprefix(s)))
  end

  def longestsubstr(input) do
    input
    |> String.graphemes
    |> _longestsubstr
  end
end

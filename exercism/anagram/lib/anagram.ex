defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  def string_to_sorted_charlist(string) do
    string |> String.downcase() |> String.to_charlist() |> Enum.sort()
  end

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_len = String.length(base)

    candidates
    |> Enum.filter(&(base_len == String.length(&1)))
    |> Enum.filter(&(String.downcase(base) != String.downcase(&1)))
    |> Enum.filter(&(string_to_sorted_charlist(base) == string_to_sorted_charlist(&1)))
  end
end

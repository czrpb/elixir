defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence = sentence
    |> String.downcase()
    |> String.replace([" ", "-"], "")

    original_length = String.length(sentence)

    unique_char =
      sentence
      |> String.to_charlist()
      |> MapSet.new()
      |> MapSet.size()

    original_length == unique_char
  end
end

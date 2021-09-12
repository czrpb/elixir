defmodule Scrabble do
  @moduledoc """
  Calculate the scrabble score for the word.
  """

  @one_pt 'aeioulnrst'
  @two_pt 'dg'
  @three_pt 'bcmp'
  @four_pt 'fhvwy'
  @five_pt 'k'
  @eight_pt 'jx'
  @ten_pt 'qz'

  @spec score(String.t()) :: non_neg_integer

  def score(word) do
    score(word |> String.downcase() |> String.to_charlist(), 0)
  end

  defp score('', sum), do: sum

  defp score([c | chars], sum) do
    score(
      chars,
      sum +
        cond do
          c in @one_pt -> 1
          c in @two_pt -> 2
          c in @three_pt -> 3
          c in @four_pt -> 4
          c in @five_pt -> 5
          c in @eight_pt -> 8
          c in @ten_pt -> 10
          true -> 0
        end
    )
  end
end

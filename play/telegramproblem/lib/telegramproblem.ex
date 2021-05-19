defmodule TelegramProblem do
  @moduledoc """
  Documentation for `TelegramProblem`.
  """

  defp get_words(words) do
    words
    |> String.split([" ", "\n"])
  end

  defp combine_words(words, max_length) do
    {{_, lastline}, lines} = words
    |> Enum.reduce(
      {{0, ""}, []},
      fn
        word, {{0, ""}, []} -> {{String.length(word), word}, []}

        word, {{currentlinelen, currentline}, lines}
          when currentlinelen + byte_size(word) < max_length ->
            {
              {currentlinelen + String.length(word) + 1, "#{currentline} #{word}"},
              lines
            }

        word, {{_, currentline}, lines} ->
          {{String.length(word), word}, [currentline|lines]}
      end
    )
    [lastline | lines]
  end

  defp combine_lines(lines) do
    lines
    |> Enum.reverse
    |> Enum.join("\n")
  end

  def solve(words, max_length) do
    words
    |> get_words
    |> combine_words(max_length)
    |> combine_lines
  end
end

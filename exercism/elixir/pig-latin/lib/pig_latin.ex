defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant
  moved to the end of the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to
  the end of the word.

  Some groups of letters are treated like consonants,
  including "ch", "qu", "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @consonants_re ~r/^(qu|[zyxwvtsrqpnmlkjhgfdcb]qu|[zyxwvtsrqpnmlkjhgfdcb]+)(.*)$/

  @vowels_re ~r/^([aeiou]+|[xy][zyxwvtsrqpnmlkjhgfdcb])(.*)$/

  defp starts_with_consonant?(word) do
    Regex.match?(@consonants_re, word)
  end
  defp pigify_consonant(word) do
    [_, move, head] = Regex.run(@consonants_re, word)
    head <> move <> "ay"
  end

  defp starts_with_vowel?(word) do
    Regex.match?(@vowels_re, word)
  end
  defp pigify_vowel(word) do
    word <> "ay"
  end

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Enum.map(fn word ->
      cond do
        starts_with_vowel?(word) -> pigify_vowel(word)
        starts_with_consonant?(word) -> pigify_consonant(word)
        true -> word
      end
    end)
    |> Enum.join(" ")
  end
end

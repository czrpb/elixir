defmodule Bob do
  defp is_yell?(input) do
    not Regex.match?(~r/[a-z]/, input)
    and
    (Regex.match?(~r/[A-Z]/, input)
     or
     Regex.match?(~r/[А-Я]/, input)   # Russian cap letters
    )
  end

  defp is_question?(input) do
    String.ends_with?(input, "?")
  end

  defp is_silence?(input) do
    input == "" or Regex.match?(~r/^\s+$/, input)
  end

  def hey(input) do
    input = input |> String.trim
    cond do
      is_silence?(input) -> "Fine. Be that way!"
      is_yell?(input) and is_question?(input) -> "Calm down, I know what I'm doing!"
      is_yell?(input) -> "Whoa, chill out!"
      is_question?(input) -> "Sure."
      true -> "Whatever."
    end
  end
end

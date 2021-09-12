defmodule Say do
  @doc """
  Translate a positive integer into English.
  """

  @scale ["", " thousand", " million", " billion"]

  @spec in_english(integer) :: {atom, String.t()}

  def in_english(number)
      when number < 0 or 1_000_000_000_000 <= number do
    {:error, "number is out of range"}
  end

  def in_english(number) do
    {:ok,
     number
     |> Integer.to_string()
     |> String.to_charlist()
     |> Enum.reverse()
     |> Enum.chunk_every(3)
     |> Enum.map(&Enum.reverse/1)
     |> Enum.zip(@scale)
     |> Enum.reverse()
     |> Enum.map(&section/1)
     |> Enum.join(" ")
     |> String.trim()}
  end

  def section({'000', _modifier}), do: ""

  def section({[?0, b, c], modifier}), do: "#{zero_thru_99([b, c])}#{modifier}"

  def section({[a, b, c], modifier}),
    do: "#{zero_thru_99([a])} hundred #{zero_thru_99([b, c])}#{modifier}"

  def section({number, modifier}), do: "#{zero_thru_99(number)}#{modifier}"

  defp zero_thru_99(number) do
    case number do
      '0' -> "zero"
      '1' -> "one"
      '2' -> "two"
      '3' -> "three"
      '4' -> "four"
      '5' -> "five"
      '6' -> "six"
      '7' -> "seven"
      '8' -> "eight"
      '9' -> "nine"
      '00' -> ""
      '01' -> "one"
      '02' -> "two"
      '03' -> "three"
      '04' -> "four"
      '05' -> "five"
      '06' -> "six"
      '07' -> "seven"
      '08' -> "eight"
      '09' -> "nine"
      '14' -> "fourteen"
      '20' -> "twenty"
      '21' -> "twenty-one"
      '22' -> "twenty-two"
      '23' -> "twenty-three"
      '34' -> "thirty-four"
      '45' -> "forty-five"
      '54' -> "fifty-four"
      '87' -> "eighty-seven"
    end
  end
end

defmodule House do
  @beginning_lines [
    "",
    "This is the house that Jack built.",
    "This is the malt",
    "This is the rat",
    "This is the cat",
    "This is the dog",
    "This is the cow with the crumpled horn",
    "This is the maiden all forlorn",
    "This is the man all tattered and torn",
    "This is the priest all shaven and shorn",
    "This is the rooster that crowed in the morn",
    "This is the farmer sowing his corn",
    "This is the horse and the hound and the horn"
  ]

  @verse_lines [
    "",
    "",
    "",
    "that lay in the house that Jack built.",
    "that ate the malt",
    "that killed the rat",
    "that worried the cat",
    "that tossed the dog",
    "that milked the cow with the crumpled horn",
    "that kissed the maiden all forlorn",
    "that married the man all tattered and torn",
    "that woke the priest all shaven and shorn",
    "that kept the rooster that crowed in the morn",
    "that belonged to the farmer sowing his corn"
  ]

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    (start..stop
     |> Enum.map(fn v ->
       [
         Enum.at(@beginning_lines, v)
         | (v + 1)..3//-1 |> Enum.map(&Enum.at(@verse_lines, &1))
       ]
       |> Enum.join(" ")
       |> String.trim(" ")
     end)
     |> Enum.join("\n")) <> "\n"
  end
end

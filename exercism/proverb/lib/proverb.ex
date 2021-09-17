defmodule Proverb do
  @old_verses %{
    "nail" => "And all for the want of a nail",
    "shoe" => "nail",
    "horse" => "shoe",
    "rider" => "horse",
    "message" => "rider",
    "battle" => "message",
    "kingdom" => "battle"
  }

  @new_verses %{
    "pin" => "And all for the want of a pin",
    "gun" => "pin",
    "soldier" => "gun",
    "battle" => "soldier"
  }

  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite([verse | strings]) do
    verses =
      case verse do
        "nail" -> @old_verses
        "pin" -> @new_verses
      end

    ((strings
     |> Enum.map(fn
       string ->
         "For want of a #{Map.get(verses, string)} the #{string} was lost"
     end)) ++ [""]
     |> Enum.join(".\n")) <> "#{Map.get(verses, verse)}.\n"
  end
end

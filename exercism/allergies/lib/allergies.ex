defmodule Allergies do
  import Bitwise

  @allergines [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"
  ]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    @allergines
    |> Enum.with_index()
    |> Enum.reduce([], fn
      {allergine, offset}, acc ->
        case round(:math.pow(2, offset)) &&& flags do
          0 -> acc
          _ -> [allergine | acc]
        end
    end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    (round(:math.pow(2, Enum.find_index(@allergines, &(&1 == item)))) &&& flags) != 0
  end
end

defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[
    strength dexterity constitution intelligence
    wisdom charisma hitpoints
  ]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    (score-10)/2 |> floor
  end

  @spec ability :: pos_integer()
  def ability do
    [:random.uniform(6), :random.uniform(6), :random.uniform(6), :random.uniform(6)]
    |> Enum.sort
    |> tl
    |> Enum.sum
  end

  @spec character :: t()
  def character do
    constitution = ability()
    hitpoints = 10 + modifier(constitution)

    %DndCharacter{
      constitution: constitution,
      hitpoints: hitpoints,

      strength: ability(),
      dexterity: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }
  end
end

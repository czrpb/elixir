defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, char)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%LoafOfBread{}, %Character{health: curr_health} = char) do
      {nil, %Character{char | health: curr_health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: strength}, %Character{mana: curr_mana} = char) do
      {%EmptyBottle{}, %Character{char | mana: curr_mana + strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison{}, %Character{health: _curr_health} = char) do
      {%EmptyBottle{}, %Character{char | health: 0}}
    end
  end
end

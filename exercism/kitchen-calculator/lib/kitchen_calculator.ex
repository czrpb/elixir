defmodule KitchenCalculator do
  @mill_to_mill 1
  @cup_to_mill  240
  @floc_to_mill 30
  @tsp_to_mill 5
  @tbsp_to_mill 15

  def get_volume(volume_pair) do
    {_, vol} = volume_pair
    vol
  end

  def to_milliliter({:milliliter, vol}), do: {:milliliter, vol * @mill_to_mill}
  def to_milliliter({:cup, vol}), do: {:milliliter, vol * @cup_to_mill}
  def to_milliliter({:fluid_ounce, vol}), do: {:milliliter, vol * @floc_to_mill}
  def to_milliliter({:teaspoon, vol}), do: {:milliliter, vol * @tsp_to_mill}
  def to_milliliter({:tablespoon, vol}), do: {:milliliter, vol * @tbsp_to_mill}

  def from_milliliter({:milliliter, vol}, :milliliter), do: {:milliliter, vol / @mill_to_mill}
  def from_milliliter({:milliliter, vol}, :cup), do: {:cup, vol / @cup_to_mill}
  def from_milliliter({:milliliter, vol}, :fluid_ounce), do: {:fluid_ounce, vol / @floc_to_mill}
  def from_milliliter({:milliliter, vol}, :teaspoon), do: {:teaspoon, vol / @tsp_to_mill}
  def from_milliliter({:milliliter, vol}, :tablespoon), do: {:tablespoon, vol / @tbsp_to_mill}

  def convert(unit_vol, to_unit) do
    unit_vol |> to_milliliter |> from_milliliter(to_unit)
  end
end

defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def increase_quantity(item, count) do
    %{
      item
      | quantity_by_size:
          Enum.into(item.quantity_by_size, %{}, fn {size, cur_count} ->
            {size, cur_count + count}
          end)
    }
  end

  def total_quantity(item) do
    Enum.map(item.quantity_by_size, fn {_, v} -> v end)
    |> Enum.sum()
  end
end

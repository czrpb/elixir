defmodule MapGroupByRange do
  defp _put({{min, max}, values}=item, value, _within)
  when value == min or value == max or is_map_key(values, value) do
    item
  end
  defp _put({{min, max}=key, values}, value, _within)
  when min < value and value < max do
    {key, Map.put(values, value, true)}
  end
  defp _put({{v, v}, values}, value, within)
  when v - within <= value and value <= v + within do
    if value < v do
      {{value, v}, values}
    else
      {{v, value}, values}
    end
  end
  defp _put({{min, max}, values}, value, within)
  when value < min and min - within <= value do
    {{value, max}, Map.put(values, min, true)}
  end
  defp _put({{min, max}, values}, value, within)
  when value > max and value <= max + within do
    {{min, value}, Map.put(values, max, true)}
  end
  defp _put(item, _value, _within), do: item

  def put(value, map, _)
  when map_size(map) == 0 do
    %{{value, value} => %{}}
  end
  def put(value, map, within) do
    new_map = Enum.into(map, %{}, &_put(&1, value, within))
    if new_map == map do
      Map.put(map, {value, value}, %{})
    else
      new_map
    end
  end
end

one_to_5 = 1..5 |> Enum.to_list
onehundred_to_105 = 100..105 |> Enum.to_list
onethousand_to_1005 = 1000..1005 |> Enum.to_list

test01 = one_to_5 ++ onehundred_to_105 ++ onethousand_to_1005

test01
|> Enum.shuffle
|> tap(&(&1|>inspect|>IO.puts))
|> Enum.reduce(
  %{},
  fn n, acc ->
    MapGroupByRange.put(n, acc, 10)
  end
)
#|> Enum.into(%{}, &MapGroupByRange.put(&1, %{}, 10))
|> inspect
|> IO.puts

defmodule HowManyNumbersAreSmallerThanTheCurrentNumber do
  def go(list) do
    list
    |> Enum.map(
      fn e ->
        Enum.count(list, &(&1<e))
      end
    )
  end

  def go2(list) do
    {result, _} = list
    |> Enum.with_index
    |> Enum.sort
    |> Enum.with_index
    |> Enum.map_reduce(
      {:nil, 0},
      fn {{e, original_i}, i}, {previous_e, previous_different_nums_index} ->
        if e != previous_e do
          {{original_i, i}, {e, i}}
        else
          {{original_i, previous_different_nums_index}, {e, previous_different_nums_index}}
        end
      end
    )
    result
    |> Enum.sort
    |> Enum.map(fn {_, n} -> n end)
  end
end

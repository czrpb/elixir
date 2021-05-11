defmodule FirstLastInSortedArray do

  def find_sol1(l, num) do
    Enum.reduce_while(
      Enum.with_index(l),
      {-1, -1},
      fn {val, idx}, acc ->
        cond do
          val == num ->
            case acc do
              {-1, -1} -> {:cont, {idx, idx}}
              {first, _} -> {:cont, {first, idx}}
            end
          num < val ->
            {:halt, acc}
          true ->
            {:cont, acc}
        end
      end
    )
  end

  defp find_sol2(l, num, {low, high} = answer) do
#    l |> inspect |> IO.puts
    cond do
      Enum.at(l, low) == num and num == Enum.at(l, high) -> answer
      Enum.at(l, low) == num -> find_sol2(l, num, {low, high-1})
      num == Enum.at(l, high) -> find_sol2(l, num, {low+1, high})
      high < low -> {-1, -1}
      true -> find_sol2(l, num, {low+1, high-1})
    end
  end
  def find_sol2(l, num) do
    cond do
      l == [] -> {-1, -1}
      List.last(l) < num -> {-1, -1}
      num < List.first(l) -> {-1, -1}
      true ->
        find_sol2(l, num, {0, Enum.count(l)-1})
    end
  end

  def find([target|l]) do
    IO.puts("#{target} found at #{find_sol1(l, target) |> inspect}")
    IO.puts("#{target} found at #{find_sol2(l, target) |> inspect}")
  end

end

System.argv()
|> Enum.map(&String.to_integer/1)
|> FirstLastInSortedArray.find

0..1000
|> Enum.map(fn _ -> :rand.uniform(500) end)
|> Enum.sort
|> (fn l -> FirstLastInSortedArray.find([Enum.random(l)|l]) end).()

defmodule FindDups do
  def find_dups(nums) do
    {_, _, dups} = nums |> Enum.reduce(
      {nums, [], []},
      fn item, {[item|remaining], to, dups} ->
        if Enum.any?(to, &(&1==item)) do
          {remaining, [item|to], [item|dups]}
        else
          {remaining, [item|to], dups}
        end
      end
      )
    dups
  end

  def find_dups2(nums) do
    {_, _, dups} = nums |> Enum.reduce(
      {nums, [], []},
      fn item, {[item|remaining], to, dups} ->
        cond do
          Enum.any?(dups, &(&1==item)) ->
            {remaining, [item|to], dups}
          Enum.any?(to, &(&1==item)) ->
            {remaining, [item|to], [item|dups]}
          true ->
            {remaining, [item|to], dups}
        end
      end
      )
    dups
  end

  def find_dups3(nums) do
    {_, _, dups} = nums |> Enum.reduce(
      {nums, [], []},
      fn item, {[item|remaining], to, dups} ->
        cond do
          Enum.any?(dups, &(&1==item)) ->
            {remaining, to, dups}
          Enum.any?(to, &(&1==item)) ->
            {remaining, to, [item|dups]}
          true ->
            {remaining, [item|to], dups}
        end
      end
      )
    dups
  end

end

[num_of_nums | [range | []]] = System.argv
|> Enum.map(&String.to_integer/1)

nums = 1..num_of_nums
|> Enum.map(fn _ -> :rand.uniform(range) end)

IO.puts("Ver1")
{ms, _ver1} = :timer.tc(fn ->
  nums
  |> FindDups.find_dups
end)
IO.puts("Ran in #{ms/1000000}s")

IO.puts("Ver2")
{ms, ver2} = :timer.tc(fn ->
  nums
  |> FindDups.find_dups2
end)
IO.puts("Ran in #{ms/1000000}s")

IO.puts("Ver3")
{ms, ver3} =  :timer.tc(fn ->
  nums
  |> FindDups.find_dups3
end)
IO.puts("Ran in #{ms/1000000}s")

IO.puts("eq?")
IO.puts(ver2 == ver3)

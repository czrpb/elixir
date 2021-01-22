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
end

System.argv
|> Enum.map(&String.to_integer/1)
|> FindDups.find_dups
|> inspect
|> IO.puts

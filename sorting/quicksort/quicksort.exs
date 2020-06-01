defmodule Quick do
  defp _sort([]) do
    []
  end

  defp _sort([a]) do
    [a]
  end

  defp _sort([a|l]) do
    {l, r} = Enum.split_with(l, &(&1<a))
    _sort(l) ++ [a] ++  _sort(r)
  end

  def sort(list) do
    _sort(list)
  end
end

[] |> Quick.sort |> inspect |> IO.puts
[1] |> Quick.sort |> inspect |> IO.puts

[1, 2] |> Quick.sort |> inspect |> IO.puts
[2, 1] |> Quick.sort |> inspect |> IO.puts

[1, 2, 3] |> Quick.sort |> inspect |> IO.puts
[1, 3, 2] |> Quick.sort |> inspect |> IO.puts

[2, 1, 3] |> Quick.sort |> inspect |> IO.puts
[2, 3, 1] |> Quick.sort |> inspect |> IO.puts

[3, 1, 2] |> Quick.sort |> inspect |> IO.puts
[3, 2, 1] |> Quick.sort |> inspect |> IO.puts

IO.puts("\n1..5")
1..5 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts

IO.puts("\n..500")
1..500 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts

IO.puts("\n..5000")
1..5000 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..5000 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts
1..5000 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts

IO.puts("\n..50000")
1..50000 |> Enum.shuffle |> Quick.sort |> inspect |> IO.puts

defmodule Merge do
  defp _sort([]) do
    []
  end

  defp _sort([l|[]]) do
    l
  end

  defp _sort([[a], [b]]) do
    cond do
      a<b -> [a,b]
      true -> [b,a]
    end
  end

  defp _sort(list_of_lists) do
    ">>> #{list_of_lists |> inspect}" |> IO.puts
    list_of_lists
    |> Enum.chunk_every(2)
    |> Enum.map(&_sort/1)
    |> _sort
  end

  def sort(list) do
    _sort(Enum.chunk_every(list, 1))
  end
end

[] |> Merge.sort |> inspect |> IO.puts
[1] |> Merge.sort |> inspect |> IO.puts

[1, 2] |> Merge.sort |> inspect |> IO.puts
[2, 1] |> Merge.sort |> inspect |> IO.puts

[1, 2, 3] |> Merge.sort |> inspect |> IO.puts
[1, 3, 2] |> Merge.sort |> inspect |> IO.puts

1/0

[2, 1, 3] |> Merge.sort |> inspect |> IO.puts
[2, 3, 1] |> Merge.sort |> inspect |> IO.puts

[3, 1, 2] |> Merge.sort |> inspect |> IO.puts
[3, 2, 1] |> Merge.sort |> inspect |> IO.puts

IO.puts("\n1..5")
1..5 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts

IO.puts("\n..500")
1..500 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts

IO.puts("\n..5000")
1..5000 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..5000 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts
1..5000 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts

IO.puts("\n..50000")
1..50000 |> Enum.shuffle |> Merge.sort |> inspect |> IO.puts

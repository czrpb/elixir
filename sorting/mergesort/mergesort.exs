defmodule Merge do
  defp _sort({[], [], m}) do
    m
  end

  defp _sort({[a], [], []}) do
    [a]
  end

  defp _sort({l, [], m}) do
    _sort({l, m, []})
  end
  defp _sort({[], r, m}) do
    _sort({r, m, []})
  end

  defp _sort({[a|l], [b|r], m}) do
    cond do
      a<b -> _sort({[a|l], r, [b|m]})
      b<=a -> _sort({l, [b|r], [a|m]})
    end
  end

  def sort(list) do
    _sort({list, [], []})
  end
end

[] |> Merge.sort |> inspect |> IO.puts
[1] |> Merge.sort |> inspect |> IO.puts

[1, 2] |> Merge.sort |> inspect |> IO.puts
[2, 1] |> Merge.sort |> inspect |> IO.puts

[1, 2, 3] |> Merge.sort |> inspect |> IO.puts
[1, 3, 2] |> Merge.sort |> inspect |> IO.puts

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

defmodule Bubble do
  defp _sort({[], [], l}) do
    l
  end

  defp _sort({[a], [], []}) do
    _sort({[], [], [a]})
  end

  defp _sort({[a], n, s}) do
    _sort({n, [], [a|s]})
  end

  defp _sort({[a,b|r], n, s}) do
    cond do
      b<a -> _sort({[a|r], [b|n], s})
      true -> _sort({[b|r], [a|n], s})
    end
  end

  def sort(list) do
    _sort({list, [], []})
  end
end

[] |> Bubble.sort |> inspect |> IO.puts
[1] |> Bubble.sort |> inspect |> IO.puts

[1, 2] |> Bubble.sort |> inspect |> IO.puts
[2, 1] |> Bubble.sort |> inspect |> IO.puts

[1, 2, 3] |> Bubble.sort |> inspect |> IO.puts
[1, 3, 2] |> Bubble.sort |> inspect |> IO.puts

[2, 1, 3] |> Bubble.sort |> inspect |> IO.puts
[2, 3, 1] |> Bubble.sort |> inspect |> IO.puts

[3, 1, 2] |> Bubble.sort |> inspect |> IO.puts
[3, 2, 1] |> Bubble.sort |> inspect |> IO.puts

IO.puts("1..5")
1..5 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..5 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts

IO.puts("\n..500")
1..500 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..500 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts

IO.puts("\n..5000")
1..5000 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..5000 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts
1..5000 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts

IO.puts("\n..50000")
1..50000 |> Enum.shuffle |> Bubble.sort |> inspect |> IO.puts

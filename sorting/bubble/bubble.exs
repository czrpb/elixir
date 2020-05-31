defmodule Bubble do
  defp _sort([]) do
    []
  end
  defp _sort([a]) do
    [a]
  end
  defp _sort([a,b|[]]=list) do
    cond do
      b<a -> [b, a]
      true -> list
    end
  end
  defp _sort([a,b|c]) do
    cond do
      b<a -> [b] ++ _sort([a|c])
      true -> [a] ++ _sort([b|c])
    end
  end
  def sort(list) do
    _sort(list)
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


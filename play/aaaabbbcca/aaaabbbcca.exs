defmodule A4B3C2A do

  defp result([], found, res) do
    [found|res] |> Enum.reverse
  end
  defp result([c|cs], {lastseen, count}, res)
    when c == lastseen do
    result(cs, {lastseen, count+1}, res)
  end
  defp result([c|cs], {lastseen, count}, res)
    when lastseen == nil do
    result(cs, {c, count+1}, res)
  end
  defp result([c|cs], found, res) do
    result(cs, {c, 1}, [found|res])
  end

  def convert(s) do
    l = s |> String.split("") |> Enum.filter(&(&1!=""))

    result(l, {nil, 0}, [])
  end

  def convert2(s) do
    l = s
    |> String.split("")
    |> Enum.filter(&(&1!=""))
    |> Enum.chunk_by(&(&1))
    |> Enum.map(fn [c|_]=cs -> {c, Enum.count(cs)} end)
  end

  def convert3(s) do
    l = s
    |> String.split("")
    |> Enum.filter(&(&1!=""))
    |> Enum.reduce(
      [],
      fn
        c, [{last, count}|tail] when c == last ->
          [{last,count+1}|tail]
        c, acc ->
          [{c, 1}|acc]
      end
    )
    |> Enum.reverse
  end
end

[input|_] = System.argv

IO.puts("Testing: #{input}")

output = A4B3C2A.convert(input)
IO.puts("Got: #{inspect(output)}")

output = A4B3C2A.convert2(input)
IO.puts("Got2: #{inspect(output)}")

output = A4B3C2A.convert3(input)
IO.puts("Got3: #{inspect(output)}")

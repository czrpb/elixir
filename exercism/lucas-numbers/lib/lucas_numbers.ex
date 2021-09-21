defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count)
      when not is_integer(count) or count < 1 do
    raise ArgumentError, message: "count must be specified as an integer >= 1"
  end

  def generate(count)
      when is_integer(count) and count > 0 do
    case count do
      1 ->
        [2]

      2 ->
        [2, 1]

      count ->
        Stream.iterate([1, 2], fn [x, y | previous] -> [x + y, x, y | previous] end)
        |> Enum.take(count - 1)
        |> Enum.reverse()
        #        |> tap(fn v -> v |> inspect |> IO.puts() end)
        |> hd
        |> Enum.reverse()
    end
  end
end

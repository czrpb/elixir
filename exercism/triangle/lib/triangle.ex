defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    sides = [a, b, c]

    cond do
      ### ERROR Conditions
      sides |> Enum.map(&(&1 <= 0)) |> Enum.any? ->
        {:error, "all side lengths must be positive"}

      sides |> Enum.sort |> (fn [a, b, c] -> a+b < c end).() ->
        {:error, "side lengths violate triangle inequality"}

      ### Valid triangle
      true ->
        num_of_different_sides = sides
        |> MapSet.new
        |> Enum.count
        case num_of_different_sides do
          1 -> {:ok, :equilateral}
          2 -> {:ok, :isosceles}
          3 -> {:ok, :scalene}
        end
    end
  end
end

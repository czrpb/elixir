defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def row(num) do
    case num do
      1 -> [1]
      2 -> [1, 1]
      _ -> [1] ++ (Enum.chunk_every(row(num-1),2,1,:discard)|>Enum.map(&Enum.sum/1)) ++ [1]
    end
  end

  def rows(num), do: 1..num |> Enum.map(&row/1)
end

defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number)
  when number <= 0 or number > 64 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end
  def square(number) do
    {:ok, :math.pow(2, number - 1)|>round}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok,
     1..64
     |> Enum.map(&square/1)
     |> Enum.map(fn {:ok, n} -> n end)
     |> Enum.sum()
     |> round}
  end
end

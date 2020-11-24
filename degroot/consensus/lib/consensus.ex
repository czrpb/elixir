defmodule Consensus do
  @moduledoc """
  Documentation for `Consensus`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Consensus.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  iex> l = [[1/2, 1/4, 1/4], [1/3, 1/3, 1/3], [0, 1/4, 3/4]]
  iex> Consensus.list_to_matrix(l)
  [[1/2, 1/4, 1/4], [1/3, 1/3, 1/3], [0, 1/4, 3/4]]
  """
  def list_to_matrix(l) do
    Enum.reduce(
      Enum.with_index(l),
      Matrix.new(Enum.count(l), Enum.count(Enum.at(l, 0)), 0),
      fn {row, rn}, m ->
        Enum.reduce(
          Enum.with_index(row),
          m,
          fn {val, cn}, m ->
            Matrix.set(m, rn, cn, val)
          end
        )
      end
    )
  end

end

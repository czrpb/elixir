defmodule Matrix do
  defstruct matrix: nil

  ### Helpers

  @spec columns_from_row(row :: %{}) :: list(integer)
  defp columns_from_row(%{} = row), do: Enum.sort(row) |> Enum.map(&elem(&1, 1))

  ### API

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    %Matrix{
      :matrix =>
        String.split(input, "\n")
        |> Enum.with_index()
        |> Enum.into(%{}, fn {row, ridx} ->
          {
            ridx,
            String.split(row)
            |> Enum.with_index()
            |> Enum.into(%{}, fn {value, cidx} -> {cidx, String.to_integer(value)} end)
          }
        end)
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{} = matrix) do
    rows(matrix) |> Enum.map(&Enum.join(&1, " ")) |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{} = matrix) do
    Enum.sort(matrix.matrix) |> Enum.map(fn {_, row} -> columns_from_row(row) end)
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{} = matrix, index) do
    columns_from_row(matrix.matrix[index - 1])
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{} = matrix) do
    rows(matrix) |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{} = matrix, index) do
    Enum.sort(matrix.matrix) |> Enum.map(fn {_, row} -> row[index - 1] end)
  end
end

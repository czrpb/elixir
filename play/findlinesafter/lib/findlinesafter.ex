defmodule FindLinesAfter do
  @moduledoc """
  Documentation for `FindLinesAfter`.
  """

  def read_file(filepath \\ "README.md") do
    File.stream!(filepath)
  end

  def lines_after(str) do
    read_file
    |> Enum.reverse
    |> Enum.reduce_while(
      [],
      fn line, acc ->
        {
          (if String.starts_with?(line, str), do: :halt, else: :cont),
          [line|acc]
        }
      end
    )
  end

end

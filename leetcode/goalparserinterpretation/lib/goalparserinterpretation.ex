defmodule GoalParserInterpretation do
  @moduledoc """
  Documentation for `Goalparserinterpretation`.
  """

  def tokenize(input) do
    input
    |> String.graphemes
    |> Enum.reduce(
      [""],
      fn c, [current|previous] ->
        token = current <> c
        case token do
          "G" -> ["",token|previous]
          "()" -> ["",token|previous]
          "(al)" -> ["",token|previous]
          _ -> [token|previous]
        end
      end
    )
    |> tl
    |> Enum.reverse
  end
  def interpret(input) do
    tokenized = input |> tokenize
    
    tokenized
    |> Enum.map(
      fn token ->
        case token do
          "G" -> "G"
          "()" -> "o"
          "(al)" -> "al"
        end
      end
    )
    |> Enum.join
  end
end

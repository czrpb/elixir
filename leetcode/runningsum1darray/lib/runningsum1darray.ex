defmodule RunningSum1dArray do
  @moduledoc """
  Documentation for `RunningSum1dArray`.
  """

  def input1([], output) do
    output |> Enum.reverse
  end
  def input1([new|remaining], [total|previous]) do
    input1(remaining, [new+total,total|previous])
  end
  def input1([first|rest]) do
    input1(rest, [first])
  end

  def input2(input) do
    input |> Enum.scan(0, &(&1+&2))
  end
end

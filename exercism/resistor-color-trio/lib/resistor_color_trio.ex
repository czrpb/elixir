defmodule ResistorColorTrio do
  @moduledoc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """

  @label_to_value %{
    :black => 0,
    :brown => 1,
    :red => 2,
    :orange => 3,
    :yellow => 4,
    :green => 5,
    :blue => 6,
    :violet => 7,
    :grey => 8,
    :white => 9
  }

  @spec label(colors :: [atom]) :: {integer, :ohms | :kiloohms}
  def label([tens, ones, zeros]) do
    ones = @label_to_value[ones]
    tens = @label_to_value[tens] * 10
    zeros = :math.pow(10, @label_to_value[zeros]) |> round

    result = (ones+tens)*zeros

    if 1000 <= result do
      {result/1000, :kiloohms}
    else
      {result, :ohms}
    end
  end
end

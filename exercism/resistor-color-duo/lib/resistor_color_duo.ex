defmodule ResistorColorDuo do
  @moduledoc """
  Calculate a resistance value from two colors
  """

  @color_to_num %{
    :black => 0,
    :brown => 1,
    :red => 2,
    :orange => 3,
    :yellow => 4,
    :green => 5,
    :blue => 6,
    :violet => 7,
    :grey => 8,
    :white => 9,
  }

  @spec value(colors :: [atom]) :: integer
  def value([first, second | _]) do
    @color_to_num[first]*10 + @color_to_num[second]
  end

end

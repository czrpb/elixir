defmodule Gigasecond do
  @gigsecond 1_000_000_000

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    from = DateTime.new!(Date.new!(year, month, day), Time.new!(hours, minutes, seconds))
    to = DateTime.add(from, @gigsecond)
    {{to.year, to.month, to.day}, {to.hour, to.minute, to.second}}
  end
end

defmodule Lasagna do
  # TODO: define the 'expected_minutes_in_oven/0' function

  @cook_time 40
  @prep_per_layer 2

  def expected_minutes_in_oven() do
    @cook_time
  end

  # TODO: define the 'remaining_minutes_in_oven/1' function

  def remaining_minutes_in_oven(cooked) do
    @cook_time - cooked
  end

  # TODO: define the 'preparation_time_in_minutes/1' function

  def preparation_time_in_minutes(num_of_layers) do
    @prep_per_layer * num_of_layers
  end

  # TODO: define the 'total_time_in_minutes/2' function

  def total_time_in_minutes(num_of_layers, cooked) do
    preparation_time_in_minutes(num_of_layers) + cooked
  end

  # TODO: define the 'alarm/0' function

  def alarm() do
    "Ding!"
  end

end

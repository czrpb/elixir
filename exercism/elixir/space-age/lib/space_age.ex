defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @quarter_day_for_leap_years 21600
  @seconds_in_earth_year 31536000 + @quarter_day_for_leap_years
  @planet_modifiers %{
    :mercury => 0.2408467,
    :venus => 0.61519726,
    :earth => 1.0,
    :mars => 1.8808158,
    :jupiter => 11.862615,
    :saturn => 29.447498,
    :uranus => 84.016846,
    :neptune => 164.79132
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """

  def age_on_earth(seconds), do: seconds / @seconds_in_earth_year

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    age_on_earth(seconds) / @planet_modifiers[planet]
  end

end

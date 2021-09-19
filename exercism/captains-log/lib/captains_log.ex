defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  defp num_of_tens(n), do: :math.log10(n) |> round

  defp random_number_range(num, {low, high} = range)
       when num <= low or high <= num do
    random_number_range(
      low + :rand.uniform() * num_of_tens(high - low),
      range
    )
  end

  defp random_number_range(num, _range), do: num

  def random_ship_registry_number() do
    "NCC-#{random_number_range(0, {1000, 9999}) |> round}"
  end

  def random_stardate() do
    stardate = random_number_range(0, {41000.0, 42000.0})
    if stardate == 42000.0, do: random_stardate(), else: stardate
  end

  def format_stardate(stardate)
      when is_float(stardate) and (41000.0 <= stardate and stardate < 42000.0) do
    stardate |> Float.round(1) |> Float.to_string()
  end

  def format_stardate(_), do: raise(ArgumentError)
end

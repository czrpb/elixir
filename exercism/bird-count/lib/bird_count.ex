defmodule BirdCount do
  def today([]), do: nil
  def today([h|_]), do: h

  def increment_day_count([]), do: [1]
  def increment_day_count([h|t]), do: [h+1|t]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0|t]), do: true
  def has_day_without_birds?([_|t]), do: has_day_without_birds?(t)

  def total(counts), do: total_(counts, 0)
  def total_([], sum), do: sum
  def total_([h|t], sum), do: total_(t, sum+h)

  def busy_days(counts), do: busy_days_(counts, 0)
  def busy_days_([], busy), do: busy
  def busy_days_([h|t], busy)
  when h >= 5 do
    busy_days_(t, busy+1)
  end
  def busy_days_([_|t], busy), do: busy_days_(t, busy)
end

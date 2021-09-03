defmodule FreelancerRates do

  @daily_rate_multiplier 8.0
  @billable_days 22

  def daily_rate(hourly_rate) do
    hourly_rate * @daily_rate_multiplier
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate * @daily_rate_multiplier * @billable_days
    |> apply_discount(discount)
    |> Float.ceil |> trunc
  end

  def days_in_budget(budget, hourly_rate, discount) do
    (budget + budget*discount/100) / daily_rate(hourly_rate) + 0.01
    |> Float.floor(1)
  end
end

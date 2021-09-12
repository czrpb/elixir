defmodule LibraryFees do
  @noon ~T[12:00:00]
  @seconds_in_a_day 60 * 60 * 24

  def datetime_from_string(string) do
    {:ok, datetime, 0} = DateTime.from_iso8601(string)
    DateTime.to_naive(datetime)
  end

  def naive_to_datetime_date_time(naive) do
    datetime = DateTime.from_naive!(naive, "Etc/UTC")
    date = DateTime.to_date(datetime)
    time = DateTime.to_time(datetime)
    {datetime, date, time}
  end

  def make_noon(date) do
    {:ok, date_noon} = DateTime.new(date, @noon)
    date_noon
  end

  def before_noon?(naive) do
    {datetime, date, _} = naive_to_datetime_date_time(naive)
    date_noon = make_noon(date)
    :lt == DateTime.compare(datetime, date_noon)
  end

  def return_date(naive) do
    return_in = 28 + if before_noon?(naive), do: 0, else: 1
    {datetime, date, _} = naive_to_datetime_date_time(naive)

    DateTime.add(datetime, return_in * @seconds_in_a_day, :second)
    |> DateTime.to_date()
  end

  def days_late(expected_return_date, actual_return_naive) do
    {_, actual_return_date, _} = naive_to_datetime_date_time(actual_return_naive)
    actual_return_noon = make_noon(actual_return_date)
    expected_return_noon = make_noon(expected_return_date)
    diff = DateTime.diff(actual_return_noon, expected_return_noon)
    if diff < 0, do: 0, else: diff / @seconds_in_a_day
  end

  def monday?(naive) do
    {_, date, _} = naive_to_datetime_date_time(naive)
    Date.day_of_week(date) == 1
  end

  def calculate_late_fee(checkedout, returned, rate) do
    checkedout_datetime = datetime_from_string(checkedout)
    returned_datetime = datetime_from_string(returned)

    modifier = if monday?(returned_datetime), do: 0.5, else: 1

    (days_late(return_date(checkedout_datetime), returned_datetime) * rate * modifier)
    |> trunc
  end
end

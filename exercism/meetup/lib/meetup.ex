defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekday2day %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  @scheduled_week [:first, :second, :third, :fourth]

  def days_between_first_and_desired(first, desired) do
    if desired >= first do
      desired - first
    else
      7 - first + desired
    end
  end

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule)
      when schedule in @scheduled_week do
    first_of_month = Date.new!(year, month, 1)
    first_as_day = Date.day_of_week(first_of_month)
    inc_in_days = days_between_first_and_desired(first_as_day, @weekday2day[weekday])
    inc_in_days = inc_in_days + 7 * Enum.find_index(@scheduled_week, &(&1 == schedule))
    Date.add(first_of_month, inc_in_days)
  end

  def meetup(year, month, weekday, :last) do
    last_of_month = Date.end_of_month(Date.new!(year, month, 1))
    last_as_day = Date.day_of_week(last_of_month)
    inc_in_days = days_between_first_and_desired(@weekday2day[weekday], last_as_day)
    Date.add(last_of_month, -inc_in_days)
  end

  def meetup(year, month, weekday, :teenth) do
    first_of_month = Date.new!(year, month, 1)
    first_as_day = Date.day_of_week(first_of_month)
    inc_in_days = days_between_first_and_desired(first_as_day, @weekday2day[weekday])
    first_weekday_as_date = Date.add(first_of_month, inc_in_days)

    if first_weekday_as_date.day < 6 do
      Date.add(first_weekday_as_date, 14)
    else
      Date.add(first_weekday_as_date, 7)
    end
  end
end

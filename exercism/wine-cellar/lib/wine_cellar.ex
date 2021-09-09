defmodule WineCellar do

  @wine_explanations [
    {:white, "Fermented without skin contact."},
    {:red,   "Fermented with skin contact using dark-colored grapes."},
    {:rose,  "Fermented with some skin contact, but not enough to qualify as a red wine."}
  ]

  @wines [
    white: {"Chardonnay", 2015, "Italy"},
    white: {"Pinot grigio", 2017, "Germany"},
    red: {"Pinot noir", 2016, "France"},
    rose: {"Dornfelder", 2018, "Germany"}
  ]


  def explain_colors do
    @wine_explanations
  end

  def filter(cellar, color, opts \\ []) do
    year = Keyword.get(opts, :year)
    country = Keyword.get(opts, :country)

    cellar
    |> Enum.filter(fn
      {^color, {_, ^year, ^country}} when not (is_nil(year) or is_nil(country)) -> true
      {^color, {_, ^year, _}} when not is_nil(year) and is_nil(country) -> true
      {^color, {_, _, ^country}} when is_nil(year) and not is_nil(country) -> true
      {^color, _} when is_nil(year) and is_nil(country) -> true
      _ -> false
    end)
    |> Keyword.values
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end

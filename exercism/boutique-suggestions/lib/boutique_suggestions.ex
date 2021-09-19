defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ [{:maximum_price, 100.0}])

  def get_combinations(tops, bottoms, options) do
    max_price =
      case options[:maximum_price] do
        nil -> 100.0
        x -> x
      end

    for %{:base_color => tcolor, :price => tprice} = top <- tops,
        tprice <= max_price,
        %{:base_color => bcolor, :price => bprice} = bottom <- bottoms,
        bprice <= max_price,
        tprice + bprice <= max_price,
        tcolor != bcolor do
      {top, bottom}
    end
  end
end

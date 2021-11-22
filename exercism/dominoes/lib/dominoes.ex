 defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  defp build([], chain), do: chain

  defp build(dominoes, [{cf, _}|_]=chain) do
    match = Enum.filter(dominoes, fn {f, l} -> (cf == f) or (cf == l) end)
    build(dominoes, )
  end

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino] | []) :: boolean
  def chain?([]), do: true
  def chain?([domino|dominoes]) do
    chain = build(dominoes, [domino])

    {first_dots, _} = List.first(chain)
    {_, last_dots} = List.last(chain)
    first_dots == last_dots
  end
end

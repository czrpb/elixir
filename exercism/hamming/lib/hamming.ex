defmodule Hamming do
  @moduledoc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """

  @spec hamming_distance([char], [char], non_neg_integer) ::
          {:ok, non_neg_integer} | {:error, String.t()}

  def hamming_distance(strand1, strand2, dist \\ 0)

  def hamming_distance(strand1, strand2, _dist)
      when length(strand1) != length(strand2) do
    {:error, "strands must be of equal length"}
  end

  def hamming_distance([], [], dist), do: {:ok, dist}

  def hamming_distance([s|strand1], [s|strand2], dist), do: hamming_distance(strand1, strand2, dist)

  def hamming_distance([_|strand1], [_|strand2], dist), do: hamming_distance(strand1, strand2, dist+1)
end

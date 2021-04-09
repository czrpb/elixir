defmodule SumOfAllOddLengthSubArrays do
  def go(list) do
    # generate the odd numbers up to half the length of the given list + 1
    Stream.iterate(1, &(&1+2))
    |> Enum.take(div(Enum.count(list),2)+1)

    # build list of lists with odd lengths
    |> Enum.reduce(
      [],
      fn odd_idx, acc ->
        [Enum.chunk_every(list, odd_idx, 1, :discard)|acc]
      end
    )

    # sum the list of lists
    |> Enum.reduce(
      0,
      fn lists, acc ->
        acc +
        (lists |> Enum.map(&Enum.sum/1) |> Enum.sum)
      end
    )
  end
end

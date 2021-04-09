defmodule DecompressRunLengthEncodedList do
  def go(list) do
    list
    |> Enum.chunk_every(2, 2)
    |> Enum.flat_map(
      fn [n,e|[]] ->
        List.duplicate(e,n)
      end
    )
  end
end

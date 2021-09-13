defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean

  def isbn?(isbn) do
    isbn = String.replace(isbn, "-", "") |> String.to_charlist()

    if length(isbn) == 10 do
      try do
        sum = calc(isbn)
        rem(sum, 11) == 0
      rescue
        _ -> false
      end
    else
      false
    end
  end

  def calc(isbn) do
    isbn
    |> Enum.map(fn i -> if i == ?X, do: 10, else: i - ?0 end)
    |> Enum.zip(10..1)
    |> Enum.map(fn {a, b} -> a * b end)
    |> Enum.sum()
  end
end

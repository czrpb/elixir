defmodule VariableLengthQuantity do
  use Bitwise

  def encode(num, acc, highbit \\ 0x0)

  def encode(0, <<>>, _), do: <<0>>
  def encode(0, acc, _), do: acc

  def encode(num, acc, highbit) do
    low = num &&& 0x7F
    carry = num >>> 7
    encode(carry, <<low ||| highbit>> <> acc, 0x80)
  end

  def decode(<<encoded>>, carried, [current | rest]) do
    if (encoded &&& 0x80) == 0x80 do
      {:error, "incomplete sequence"}
    else
      {
        :ok,
        [current ||| (carried ||| (encoded &&& 0x7F)) | rest]
        |> Enum.reverse()
      }
    end
  end

  def decode(<<encoded, remaining::binary>>, carried, [current | rest]) do
    if (encoded &&& 0x80) == 0x80 do
      carry = encoded &&& 0x01
      encoded = carried ||| (encoded &&& 0x7E)
      current = (current ||| encoded) <<< 7
      decode(remaining, carry <<< 7, [current | rest])
    else
      encoded = carried ||| (encoded &&& 0x7F)
      current = current ||| encoded
      decode(remaining, 0x0, [0x0, current | rest])
    end
  end

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    integers
    |> Enum.reduce(<<>>, fn num, acc -> acc <> encode(num, <<>>) end)
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes) do
    decode(bytes, 0x0, [0x0])
  end
end

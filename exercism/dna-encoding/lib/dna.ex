defmodule DNA do

  @a_space 0b0000
  @a 0b0001
  @c 0b0010
  @g 0b0100
  @t 0b1000

  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> @a
      ?C -> @c
      ?G -> @g
      ?T -> @t
      ?\s -> @a_space
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      @a -> ?A
      @c -> ?C
      @g -> ?G
      @t -> ?T
      @a_space -> ?\s
    end
  end

  def encode(dna, encoded \\ <<>>)
  def encode([], encoded), do: encoded
  def encode([nucleotide|dna], encoded_dna) do
    encoded = encode_nucleotide(nucleotide)
    encode(dna, <<encoded_dna::bitstring, encoded::4>>)
  end

  def decode(dna, as_bitstring \\ '')
  def decode(<<>>, as_bitstring), do: as_bitstring |> Enum.reverse
  def decode(<<nucleotide::4, rest::bitstring>>, as_bitstring) do
    decode(rest, [decode_nucleotide(nucleotide)|as_bitstring])
  end
end

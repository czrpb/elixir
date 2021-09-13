defmodule Atbash do
  @alphabet_re ~r|[a-z]|
  @chars_but_alpha_nums ~r|[^a-z0-9]|

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.replace(@chars_but_alpha_nums, "")
    |> String.replace(@alphabet_re, fn <<char>> -> <<?z - (char - ?a)>> end)
    |> String.to_charlist()
    |> Enum.chunk_every(5)
    |> Enum.map(&List.to_string/1)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(@chars_but_alpha_nums, "")
    |> String.replace(@alphabet_re, fn <<char>> -> <<?a + (?z - char)>> end)
  end
end

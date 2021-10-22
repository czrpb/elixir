defmodule AffineCipher do
  @alpha_len 26

  def encrypt(_, _, char)
      when ?1 <= char and char <= ?9 do
    char
  end

  def encrypt(a, b, char) do
    Integer.mod(a * (char - ?a) + b, @alpha_len) + ?a
  end

  def decrypt(_, _, char)
      when ?1 <= char and char <= ?9 do
    char
  end

  def decrypt(mmi, b, char) do
    #    IO.puts("\n#{mmi}  #{b}  #{char}")
    Integer.mod(mmi * (char - ?a - b), @alpha_len) + ?a
  end

  def mmi(a) do
    mod = Integer.mod(a, @alpha_len)

    1..@alpha_len
    |> Stream.filter(fn n ->
      Integer.mod(mod * n, @alpha_len) == 1
    end)
    |> Enum.take(1)
  end

  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    if mmi(a) == [] do
      {:error, "a and m must be coprime."}
    else
      {
        :ok,
        message
        |> String.downcase()
        |> String.to_charlist()
        |> Enum.filter(&((?a <= &1 and &1 <= ?z) or (?1 <= &1 and &1 <= ?9)))
        |> Enum.map(&encrypt(a, b, &1))
        |> Enum.chunk_every(5)
        |> Enum.map(&List.to_string/1)
        |> Enum.join(" ")
      }
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    mmi = mmi(a)

    if mmi == [] do
      {:error, "a and m must be coprime."}
    else
      [mmi | _] = mmi

      {
        :ok,
        encrypted
        |> String.to_charlist()
        |> Enum.filter(&(&1 != 32))
        |> Enum.map(&decrypt(mmi, b, &1))
        |> List.to_string()
      }
    end
  end
end

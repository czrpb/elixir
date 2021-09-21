defmodule SimpleCipher do
  @doc """
  To encode you:

    1. Need to find the different between the letter 'a' and the letter to encode (plainchr)
    2. Add this to the cipherkey (rotatechr)
    3. If the result doesnt go beyond the letter 'z' then you have your answer
    4. But if we have gone beyond 'z' then we need to wrap, and to do this
       find the amount beyond 'z' and add this to 'a'
  """
  def encode(plainchr, rotatechr)
      when is_integer(plainchr) do
    result = plainchr - ?a + rotatechr
    if result <= ?z, do: result, else: ?a + (result - ?z - 1)
  end

  @doc """
  To decode you:

    1. Find the amount of rotation as the different between the cipherkey (rotatechr)
       and the letter 'a'
    2. Remove this from the encoded letter (cipherchr)
    3. If the result doesnt go below the letter 'a' then you have your answer
    4. But if we have gone below 'a' then we need to wrap, and to do this
       find the amount below 'a' and remove this from 'z'
  """
  def decode(cipherchr, rotatechr)
      when is_integer(cipherchr) do
    result = cipherchr - (rotatechr - ?a)
    if result >= ?a, do: result, else: ?z - (?a - result) + 1
  end

  def cipher(text, key, f) do
    {text, key} = {String.to_charlist(text), String.to_charlist(key)}

    Enum.zip(text, Stream.cycle(key))
    |> Enum.map(fn {textchr, keychr} -> {textchr, keychr, f.(textchr, keychr)} end)
    |> Enum.map(&elem(&1, 2))
    |> List.to_string()
  end

  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    cipher(plaintext, key, &encode/2)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    cipher(ciphertext, key, &decode/2)
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    for _ <- 1..length do
      Enum.random(?a..?z)
    end
    |> List.to_string()
  end
end

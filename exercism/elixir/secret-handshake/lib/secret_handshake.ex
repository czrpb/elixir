defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @commands ["jump", "close your eyes", "double blink", "wink"]

  defp commands("", [], acc, reverse) do
    if reverse == 1 do
      acc |> Enum.reverse
    else
      acc
    end
  end
  defp commands(<<bit::1, rest::bits>>, [cmd|cmds], acc, reverse) do
    #{bit, rest} |> inspect |> IO.puts
    case bit do
      1 -> commands(rest, cmds, [cmd|acc], reverse)
      0 -> commands(rest, cmds, acc, reverse)
    end
  end

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    <<reverse::1, code::4>> = <<code::5>>
    commands(<<code::4>>, @commands, [], reverse)
  end
end

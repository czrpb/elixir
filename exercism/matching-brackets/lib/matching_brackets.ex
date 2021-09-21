defmodule MatchingBrackets do
  @brackets [?(, ?), ?[, ?], ?{, ?}]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    result =
      String.to_charlist(str)
      |> Enum.reduce([], fn
        ?), [?( | stack] -> stack
        ?], [?[ | stack] -> stack
        ?}, [?{ | stack] -> stack
        chr, stack when chr in @brackets -> [chr | stack]
        _, stack -> stack
      end)

    result == []
    
  end
end

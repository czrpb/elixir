defmodule Sublist do
  @moduledoc """
  Documentation for `Sublist`.
  """

  def sublist(l1, l2) do
    cond do
      length(l1) == length(l2) -> sublist(l1, l2, :equal, l1)
      length(l1) < length(l2) -> sublist(l1, l2, :sublist, l1)
      true -> sublist(l2, l1, :superlist, l2)
    end
  end

  defp sublist([], [], result, _original), do: result

  defp sublist([], _lt2, result, _original), do: result

  defp sublist(_lt1, [], _result, _original), do: :unequal

  defp sublist([a | lt1], [a | lt2], result, original) do
    sublist(lt1, lt2, result, original)
  end

  defp sublist([_a | _], [_b  | lt2], result, original) do
    sublist(original, lt2, result, original)
  end

end

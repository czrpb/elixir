defmodule SubList1 do
  @moduledoc """
  Documentation for `SubList1`.
  """

  def sublist(l1, l2) do
    cond do
      length(l1) == length(l2) -> sublist(l1, l2, :equal, l1, [:ignore])
      length(l1) < length(l2) -> sublist(l1, l2, :sublist, l1, [:ignore])
      true -> sublist(l2, l1, :superlist, l2, [:ignore])
    end
  end

  defp sublist([], [], result, _original, _matches), do: result

  defp sublist([], _lt2, result, _original, _matches), do: result

  defp sublist(_lt1, [], _result, _original, _matches), do: :unequal

  defp sublist([a | lt1], [a | lt2], result, original, matches) do
    sublist(lt1, lt2, result, original, [a | matches])
  end

  defp sublist([_a | _], [_b | lt2]=l2, result, original, matches) do
    #{l2, lt2, matches} |> inspect |> IO.puts
    matches = matches |> Enum.reverse |> Enum.drop(2)

    sublist(
      original,
      matches ++ (if Enum.empty?(matches), do: lt2, else: l2),
      result,
      original,
      [:ignore]
    )
  end
end

defmodule SubList2 do
  def sublist(l1, l2) do
    l1_l = length(l1)
    l2_l = length(l2)

    cond do
      l1_l == l2_l -> if l1 == l2, do: :equal, else: :unequal
      l1_l < l2_l and l1 in Enum.chunk_every(l2, l1_l, 1) -> :sublist
      l2 in Enum.chunk_every(l1, l2_l, 1) -> :superlist
      true -> :unequal
    end
  end
end

defmodule SubList3 do
  @type listtype :: :unequal | :sublist | :superlist | :equal

  @spec sublist(list, list) :: listtype
  def sublist(l1, l2) do
    l1_l = length(l1)
    l2_l = length(l2)

    cond do
      l1_l == l2_l -> if l1 == l2, do: :equal, else: :unequal
      l1_l < l2_l -> sublist(l1, l2, :sublist)
      true -> sublist(l2, l1, :superlist)
    end
  end

  @spec sublist(list, list, listtype) :: listtype
  def sublist(_, [], _), do: :unequal

  def sublist(l1, [_ | l2_tl] = l2, result) do
    if List.starts_with?(l2, l1) do
      result
    else
      sublist(l1, l2_tl, result)
    end
  end
end

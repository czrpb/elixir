defmodule Sublist do
  def compare([], []), do: :equal
  def compare(a, a), do: :equal
  def compare(a, b) when length(a) == length(b) do
    :unequal
  end
  def compare(a, b)
  when length(a) < length(b) do
    compare_(a, b, [], :sublist)
  end
  def compare(a, b), do: compare_(b, a, [], :superlist)

  def compare_([], _, _, type), do: type
  def compare_(_, [], _, type), do: :unequal
  def compare_([a|as], [a|bs], matched, type) do
    compare_(as, bs, [a|matched], type)
  end
  def compare_([a|_]=as, [b|bs], [], type) do
    compare_(as, bs, [], type)
  end
  def compare_([a|_]=as, [b|_]=bs, matched, type) do
    matched = Enum.reverse(matched)
    compare_(matched++as, (matched|>tl)++bs, [], type)
  end
end

defmodule Sublist_1 do
  @moduledoc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.

  Algo:

  1. Are lists same list? then equal
  2. Is test list nil? then sublist
  3. is target list nil? then superlist
  4. if test list is shorter than target,
       if test list is at the start of target, then sublist
       if test list is at the end of target, then sublist
       else, sublist might be within
  5. if test list is longer than target,
       if target list is at the start of test, then superlist
       if target list is at the end of test, then superlist
       else, target as sublist might be within
  6. if testing test list is embedded thus sublist,
       walk down:
         a. test list until
  7. if testing target list is embedded thus superlist,
  """

  def compare(l, l), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b)
  when length(a) < length(b) do
    cond do
      Enum.take(b, length(a)) === a -> :sublist
      Enum.drop(b, length(b)-length(a)) === a -> :sublist
      true -> compare_sublist(a, b, [], Enum.reverse(a))
    end
  end
  def compare(a, b)
  when length(b) < length(a) do
    cond do
      Enum.take(a, length(b)) === b -> :superlist
      Enum.drop(a, length(a)-length(b)) === b -> :superlist
      true -> compare_superlist(a, b, [], Enum.reverse(b))
    end
  end
  def compare(_, _), do: :unequal


  defp compare_sublist([], _, a_orig, a_orig), do: :sublist
  defp compare_sublist([], _, _, _), do: :unequal
  defp compare_sublist(_, [], _, _), do: :unequal
  defp compare_sublist([a|as], [a|bs], matched, a_orig) do
    compare_sublist(as, bs, [a|matched], a_orig)
  end
  defp compare_sublist(a, [b|bs], matched, a_orig) do
    compare_sublist(Enum.reverse(matched)++a, bs, [], a_orig)
  end

  defp compare_superlist(_, [], b_orig, b_orig), do: :superlist
  defp compare_superlist(_, [], _, _), do: :unequal
  defp compare_superlist([], b_orig, _, b_orig), do: :unequal
  defp compare_superlist([a|as], [a|bs], matched, b_orig) do
    compare_superlist(as, bs, [a|matched], b_orig)
  end
  defp compare_superlist([a|as], b, matched, b_orig) do
    compare_superlist(as, Enum.reverse(matched)++b, [], b_orig)
  end
end

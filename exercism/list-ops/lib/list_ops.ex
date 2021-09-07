defmodule ListOps do
  # Please don't use any external modules (especially List or
  #  Enum) in your
  # implementation. The point of this exercise is to create
  #  these basic
  # functions yourself. You may use basic Kernel functions
  #  (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions
  #  for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  defp count([], len) do
    len
  end
  defp count([_|t], len) do
    count(t, len+1)
  end
  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp reverse([], reversed) do
    reversed
  end
  defp reverse([h|t], reversed) do
    reverse(t, [h|reversed])
  end
  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  def map([], _f, acc) do
    acc |> reverse
  end
  def map([h|t], f, acc) do
    map(t, f, [f.(h)|acc])
  end
  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  def filter([], _f, acc) do
    acc |> reverse
  end
  def filter([h|t], f, acc) do
    if f.(h) do
      filter(t, f, [h|acc])
    else
      filter(t, f, acc)
    end
  end
  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f) do
    acc
  end
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    concat([a, b])
  end

  defp concat([], acc) do
    acc
  end
  defp concat([h|t], acc) do
    new_acc = concat(h, acc)
    concat(t, new_acc)
  end
  defp concat(i, acc) do
    [i|acc]
  end
  @spec concat([[any]]) :: [any]
  def concat(ll) do
    concat(ll, [])
    |> reverse
  end
end

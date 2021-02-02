defmodule BBTree do
  @moduledoc """
  Documentation for `Bbtree`.
  """

  def tree(value) do
    {nil, {value, 1, 0}, nil}
  end
  def leaf?(tree) do
    {left, _data, right} = tree
    left == nil and right == nil
  end

  def value({_left, {value, _count, _bal}, _right}) do
    value
  end
  def count({_left, {_value, count, _bal}, _right}) do
    count
  end
  def bal({_left, {_value, _count, bal}, _right}) do
    bal
  end
  def left({left, _data, _right}) do
    left
  end
  def right({_left, _data, right}) do
    right
  end

  def insert(newvalue, tree \\ nil) do
    if tree == nil do
      tree(newvalue)
    else
      {left, {value, count, bal}, right} = tree
      newtree = cond do
        newvalue == value ->
          {left, {value, count+1, bal}, right}
        left == nil and newvalue < value ->
          subtree = tree(newvalue)
          {subtree, {value, count, bal-1}, right}
        right == nil and value < newvalue ->
          subtree = tree(newvalue)
          {left, {value, count, bal+1}, subtree}
        newvalue < value ->
          {insert(newvalue, left), {value, count, bal-1}, right}
        value < newvalue ->
          {left, {value, count, bal+1}, insert(newvalue, right)}
      end
      case newtree do
        {_left, {_value, _count, -2}, nil} ->
          balance_left(newtree)
        {nil, {_value, _count, 2}, _right} ->
          balance_right(newtree)
        _ -> newtree
      end
    end
  end
  def balance_left(tree) do
    case tree do
      {{{nil, {llv, llc, 0}, nil}, {lv, lc, -1}, nil}, {v, c, -2}, nil} ->
        {{nil, {llv, llc, 0}, nil}, {lv, lc, 0}, {nil, {v, c, 0}, nil}}
      {{nil, {lv, lc, 1}, {nil, {lrv, lrc, 0}, nil}}, {v, c, -2}, nil} ->
        {{nil, {lv, lc, 0}, nil}, {lrv, lrc, 0}, {nil, {v, c, 0}, nil}}
    end
  end
  def balance_right(tree) do
    case tree do
      {nil, {v, c, 2}, {nil, {rv, rc, 1}, {nil, {rrv, rrc, 0}, nil}}} ->
        {{nil, {v, c, 0}, nil}, {rv, rc, 0}, {nil, {rrv, rrc, 0}, nil}}
      {nil, {v, c, 2}, {{nil, {rlv, rlc, 0}, nil}, {rv, rc, -1}, nil}} ->
        {{nil, {v, c, 0}, nil}, {rlv, rlc, 0}, {nil, {rv, rc, 0}, nil}}
    end
  end
end

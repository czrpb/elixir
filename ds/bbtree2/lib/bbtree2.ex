defmodule BBTree do
  @moduledoc """
  Documentation for `BBTree`.
  """

  @type tree :: {tree, term, tree}
  @type side :: :left | :right | :none

  def tnode(val) do
    {nil, val, nil}
  end

  ### INSERT
  @spec insert(term, tree, side) :: tree
  def insert(val, nil, _side) do
    tnode(val)
  end

  def insert(newval, {left, val, right}, side)
  when newval < val
  do
    case side do
      :left -> {balance(insert(newval, left, :left)), val, right}
      _ -> {insert(newval, left, :left), val, right}
    end
  end

  def insert(newval, {left, val, right}, side)
  when newval > val
  do
    case side do
      :right -> {left, val, balance(insert(newval, right, :right))}
      _ -> {left, val, insert(newval, right, :right)}
    end
  end


  ### BALANCE
  # Balance left-left path
  def balance(
    input={
      {lleft={_llleft, _llval, _llright}, lval, lright},
      val,
      right
    }
  ) do
#    input |> inspect |> (fn tree -> IO.puts("ll: #{tree}") end).()
    {lleft, lval, {lright, val, right}}
  end

  # Balance right-right path
  def balance(
    input={
      left,
      val,
      {rleft, rval, rright={_rrleft, _rrval, _rrright}}
    }
  ) do
#    input |> inspect |> (fn tree -> IO.puts("rr: #{tree}") end).()
    {{left, val, rleft}, rval, rright}
  end

  def balance(tree), do: tree

  ### DEPTH
  def depth(nil), do: -1

  def depth({left, root, right}) do
    max(depth(left), depth(right)) + 1
  end

  ### TO LIST
  def to_list(nil), do: []

  def to_list({left, val, right}) do
    to_list(left) ++ [val] ++ to_list(right)
  end

  ### CREATE
  def new(input) do
    [root|rest] = input
    rest
    |> Enum.reduce(tnode(root), &insert(&1, &2, :none))
    |> balance
  end
end

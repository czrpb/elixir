defmodule SublistTest do
  use ExUnit.Case
  doctest Sublist

  test "sublist([], [])" do
    assert Sublist.sublist([], []) == :equal
  end

  test "sublist([1], [1])" do
    assert Sublist.sublist([1], [1]) == :equal
  end

  test "sublist([1, 2, 3], [1, 2, 3])" do
    assert Sublist.sublist([1, 2, 3], [1, 2, 3]) == :equal
  end

  test "sublist([1], [2])" do
    assert Sublist.sublist([1], [2]) == :unequal
  end

  test "sublist([1], [1, 2])" do
    assert Sublist.sublist([1], [1, 2]) == :sublist
  end

  test "sublist([2], [1, 2])" do
    assert Sublist.sublist([2], [1, 2]) == :sublist
  end

  test "sublist([1, 2], [1])" do
    assert Sublist.sublist([1, 2], [1]) == :superlist
  end

  test "sublist([1, 2], [2])" do
    assert Sublist.sublist([1, 2], [2]) == :superlist
  end

  test "sublist([1, 2, 3], [1, 5, 3])" do
    assert Sublist.sublist([1, 2, 3], [1, 5, 3]) == :unequal
  end

  test "sublist([2], [1, 2, 3])" do
    assert Sublist.sublist([2], [1, 2, 3]) == :sublist
  end

  test "sublist([1, 2, 4], [1, 2, 3, 4, 5])" do
    assert Sublist.sublist([1, 2, 4], [1, 2, 3, 4, 5]) == :unequal
  end

  test "sublist([1, 2, 3], [1, 2, 3, 4, 5])" do
    assert Sublist.sublist([1, 2, 3], [1, 2, 3, 4, 5]) == :sublist
  end

  test "sublist([3, 4, 5], [1, 2, 3, 4, 5])" do
    assert Sublist.sublist([3, 4, 5], [1, 2, 3, 4, 5]) == :sublist
  end

  test "sublist([2, 3, 4], [1, 2, 3, 4, 5])" do
    assert Sublist.sublist([2, 3, 4], [1, 2, 3, 4, 5]) == :sublist
  end
end

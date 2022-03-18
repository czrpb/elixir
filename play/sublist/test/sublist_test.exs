defmodule SubList1Test do
  use ExUnit.Case
  doctest SubList1

  test "sublist([], [])" do
    assert SubList1.sublist([], []) == :equal
    assert SubList2.sublist([], []) == :equal
    assert SubList3.sublist([], []) == :equal
  end

  test "sublist([1], [1])" do
    assert SubList1.sublist([1], [1]) == :equal
    assert SubList2.sublist([1], [1]) == :equal
    assert SubList3.sublist([1], [1]) == :equal
  end

  test "sublist([1, 2, 3], [1, 2, 3])" do
    assert SubList1.sublist([1, 2, 3], [1, 2, 3]) == :equal
    assert SubList2.sublist([1, 2, 3], [1, 2, 3]) == :equal
    assert SubList3.sublist([1, 2, 3], [1, 2, 3]) == :equal
  end

  test "sublist([1], [2])" do
    assert SubList1.sublist([1], [2]) == :unequal
    assert SubList2.sublist([1], [2]) == :unequal
    assert SubList3.sublist([1], [2]) == :unequal
  end

  test "sublist([1], [1, 2])" do
    assert SubList1.sublist([1], [1, 2]) == :sublist
    assert SubList2.sublist([1], [1, 2]) == :sublist
    assert SubList3.sublist([1], [1, 2]) == :sublist
  end

  test "sublist([2], [1, 2])" do
    assert SubList1.sublist([2], [1, 2]) == :sublist
    assert SubList2.sublist([2], [1, 2]) == :sublist
    assert SubList3.sublist([2], [1, 2]) == :sublist
  end

  test "sublist([1, 2], [1])" do
    assert SubList1.sublist([1, 2], [1]) == :superlist
    assert SubList2.sublist([1, 2], [1]) == :superlist
    assert SubList3.sublist([1, 2], [1]) == :superlist
  end

  test "sublist([1, 2], [2])" do
    assert SubList1.sublist([1, 2], [2]) == :superlist
    assert SubList2.sublist([1, 2], [2]) == :superlist
    assert SubList3.sublist([1, 2], [2]) == :superlist
  end

  test "sublist([1, 2, 3], [1, 5, 3])" do
    assert SubList1.sublist([1, 2, 3], [1, 5, 3]) == :unequal
    assert SubList2.sublist([1, 2, 3], [1, 5, 3]) == :unequal
    assert SubList3.sublist([1, 2, 3], [1, 5, 3]) == :unequal
  end

  test "sublist([2], [1, 2, 3])" do
    assert SubList1.sublist([2], [1, 2, 3]) == :sublist
    assert SubList2.sublist([2], [1, 2, 3]) == :sublist
    assert SubList3.sublist([2], [1, 2, 3]) == :sublist
  end

  test "sublist([1, 2, 4], [1, 2, 3, 4, 5])" do
    assert SubList1.sublist([1, 2, 4], [1, 2, 3, 4, 5]) == :unequal
    assert SubList2.sublist([1, 2, 4], [1, 2, 3, 4, 5]) == :unequal
    assert SubList3.sublist([1, 2, 4], [1, 2, 3, 4, 5]) == :unequal
  end

  test "sublist([1, 2, 3], [1, 2, 3, 4, 5])" do
    assert SubList1.sublist([1, 2, 3], [1, 2, 3, 4, 5]) == :sublist
    assert SubList2.sublist([1, 2, 3], [1, 2, 3, 4, 5]) == :sublist
    assert SubList3.sublist([1, 2, 3], [1, 2, 3, 4, 5]) == :sublist
  end

  test "sublist([3, 4, 5], [1, 2, 3, 4, 5])" do
    assert SubList1.sublist([3, 4, 5], [1, 2, 3, 4, 5]) == :sublist
    assert SubList2.sublist([3, 4, 5], [1, 2, 3, 4, 5]) == :sublist
    assert SubList3.sublist([3, 4, 5], [1, 2, 3, 4, 5]) == :sublist
  end

  test "sublist([2, 3, 4], [1, 2, 3, 4, 5])" do
    assert SubList1.sublist([2, 3, 4], [1, 2, 3, 4, 5]) == :sublist
    assert SubList2.sublist([2, 3, 4], [1, 2, 3, 4, 5]) == :sublist
    assert SubList3.sublist([2, 3, 4], [1, 2, 3, 4, 5]) == :sublist
  end

  test "sublist([1, 1, 2], [1, 2, 1, 1, 2])" do
    assert SubList1.sublist([1, 1, 2], [1, 2, 1, 1, 2]) == :sublist
    assert SubList2.sublist([1, 1, 2], [1, 2, 1, 1, 2]) == :sublist
    assert SubList3.sublist([1, 1, 2], [1, 2, 1, 1, 2]) == :sublist
  end

  test "sublist([1, 1, 2], [1, 1, 1, 2])" do
    assert SubList1.sublist([1, 1, 2], [1, 1, 1, 2]) == :sublist
    assert SubList2.sublist([1, 1, 2], [1, 1, 1, 2]) == :sublist
    assert SubList3.sublist([1, 1, 2], [1, 1, 1, 2]) == :sublist
  end

end

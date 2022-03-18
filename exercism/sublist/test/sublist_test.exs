defmodule SublistTest do
  use ExUnit.Case

  describe "unequal" do
    test "1 is not 2" do
      assert SubList2.compare([1], [2]) == :unequal
    end

    test "huge sublist not in huge list" do
      assert SubList2.compare(Enum.to_list(10..1_000_001), Enum.to_list(1..1_000_000)) == :unequal
    end

    test "second list missing element from first list" do
      assert SubList2.compare([1, 2, 3], [1, 3]) == :unequal
    end
    test "first list missing element from second list" do
      assert SubList2.compare([1, 3], [1, 2, 3]) == :unequal
    end

    test "same digits but different numbers" do
      assert SubList2.compare([1, 0, 1], [10, 1]) == :unequal
    end

    test "recurring values unequal" do
      assert SubList2.compare([1, 2, 1, 2, 3], [1, 2, 3, 1, 2, 3, 2, 3, 2, 1]) == :unequal
    end

    test "strict equality needed" do
      assert SubList2.compare([1], [1.0, 2]) == :unequal
    end

    test "1 and 2 does not contain 3" do
      assert SubList2.compare([1, 2], [3]) == :unequal
    end
  end

  describe "equal" do
    test "empty equals empty" do
      assert SubList2.compare([], []) == :equal
    end

    test "comparing massive equal lists" do
      l = Enum.to_list(1..1_000_000)
      assert SubList2.compare(l, l) == :equal
    end
  end

  describe "sublist" do
    test "empty is a sublist of anything" do
      assert SubList2.compare([], [nil]) == :sublist
    end

    test "sublist at start" do
      assert SubList2.compare([1, 2, 3], [1, 2, 3, 4, 5]) == :sublist
    end

    test "sublist in middle" do
      assert SubList2.compare([4, 3, 2], [5, 4, 3, 2, 1]) == :sublist
    end

    test "sublist at end" do
      assert SubList2.compare([3, 4, 5], [1, 2, 3, 4, 5]) == :sublist
    end

    test "partially matching sublist at start" do
      assert SubList2.compare([1, 1, 2], [1, 1, 1, 2]) == :sublist
    end

    test "sublist early in huge list" do
      assert SubList2.compare([3, 4, 5], Enum.to_list(1..1_000_000)) == :sublist
    end

    test "consecutive" do
      assert SubList2.compare([1, 1, 2], [0, 1, 1, 1, 2, 1, 2]) == :sublist
    end

    test "recurring values sublist" do
      assert SubList2.compare([1, 2, 1, 2, 3], [1, 2, 3, 1, 2, 1, 2, 3, 2, 1]) == :sublist
    end
  end

  describe "superlist" do
    test "anything is a superlist of empty" do
      assert SubList2.compare([nil], []) == :superlist
    end

    test "superlist early in huge list" do
      assert SubList2.compare(Enum.to_list(1..1_000_000), [3, 4, 5]) == :superlist
    end

    test "superlist at start" do
      assert SubList2.compare([1, 2, 3, 4, 5], [1, 2, 3]) == :superlist
    end

    test "superlist in middle" do
      assert SubList2.compare([5, 4, 3, 2, 1], [4, 3, 2]) == :superlist
    end

    test "superlist at end" do
      assert SubList2.compare([1, 2, 3, 4, 5], [3, 4, 5]) == :superlist
    end

    test "partially matching superlist at start" do
      assert SubList2.compare([1, 1, 1, 2], [1, 1, 2]) == :superlist
    end
  end
end

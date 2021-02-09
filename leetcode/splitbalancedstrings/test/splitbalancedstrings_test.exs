defmodule SplitBalancedStringsTest do
  use ExUnit.Case
  doctest SplitBalancedStrings

  test "'RLRRLLRLRL' -> 4" do
    input = "RLRRLLRLRL"
    expected = 4
    assert SplitBalancedStrings.countbalanced(input) == expected
  end

  test "'RLLLLRRRLR' -> 3" do
    input = "RLLLLRRRLR"
    expected = 3
    assert SplitBalancedStrings.countbalanced(input) == expected
  end

  test "'LLLLRRRR' -> 1" do
    input = "LLLLRRRR"
    expected = 1
    assert SplitBalancedStrings.countbalanced(input) == expected
  end

  test "'RLRRRLLRLL' -> 2" do
    input = "RLRRRLLRLL"
    expected = 2
    assert SplitBalancedStrings.countbalanced(input) == expected
  end
end

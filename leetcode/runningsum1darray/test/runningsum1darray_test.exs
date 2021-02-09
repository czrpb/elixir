defmodule RunningSum1dArrayTest do
  use ExUnit.Case
  doctest RunningSum1dArray

  test "[1,2,3,4] -> [1,3,6,10]" do
    input = [1,2,3,4]
    expected = [1,3,6,10]
    assert RunningSum1dArray.input1(input) == expected
    assert RunningSum1dArray.input2(input) == expected
  end

  test "[1,1,1,1,1] -> [1,2,3,4,5]" do
    input = [1,1,1,1,1]
    expected = [1,2,3,4,5]
    assert RunningSum1dArray.input1(input) == expected
    assert RunningSum1dArray.input2(input) == expected
  end

  test "[3,1,2,10,1] -> [3,4,6,16,17]" do
    input = [3,1,2,10,1]
    expected = [3,4,6,16,17]
    assert RunningSum1dArray.input1(input) == expected
    assert RunningSum1dArray.input2(input) == expected
  end
end

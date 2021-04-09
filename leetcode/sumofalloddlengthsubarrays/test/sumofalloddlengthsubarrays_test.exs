defmodule SumOfAllOddLengthSubArraysTest do
  use ExUnit.Case
  doctest SumOfAllOddLengthSubArrays

  @test1 [1, 4, 2, 5, 3]
  test "@test1 -> 58" do
    assert SumOfAllOddLengthSubArrays.go(@test1) == 58
  end

  @test2 [1, 2]
  test "@test2 -> 3" do
    assert SumOfAllOddLengthSubArrays.go(@test2) == 3
  end

  @test3 [10, 11, 12]
  test "@test2 -> 66" do
    assert SumOfAllOddLengthSubArrays.go(@test3) == 66
  end

  @test4 [3, 5, 11, 4, 7, 77, 8, 1, 1]
  test "@test4 -> 1024" do
    assert SumOfAllOddLengthSubArrays.go(@test4) == 1340
  end

  # @test2 []
  # test "@test2 -> ??" do
  #   assert SumOfAllOddLengthSubArrays.go(@test2) == ??
  # end

end

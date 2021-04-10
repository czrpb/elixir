defmodule HowManyNumbersAreSmallerThanTheCurrentNumberTest do
  use ExUnit.Case
  doctest HowManyNumbersAreSmallerThanTheCurrentNumber

  @test1_input [8, 1, 2, 2, 3]
  @test1_output [4, 0, 1, 1, 3]
  test "go: @test1_input -> @test1_output" do
    assert HowManyNumbersAreSmallerThanTheCurrentNumber.go(@test1_input) == @test1_output
  end
  test "go2: @test1_input -> @test1_output" do
    assert HowManyNumbersAreSmallerThanTheCurrentNumber.go2(@test1_input) == @test1_output
  end

  @test2_input [6, 5, 4, 8]
  @test2_output [2, 1, 0, 3]
  test "go: @test2_input -> @test2_output" do
    assert HowManyNumbersAreSmallerThanTheCurrentNumber.go(@test2_input) == @test2_output
  end
  test "go2: @test2_input -> @test2_output" do
    assert HowManyNumbersAreSmallerThanTheCurrentNumber.go2(@test2_input) == @test2_output
  end

  @test3_input [7, 7, 7, 7]
  @test3_output [0, 0, 0, 0]
  test "go: @test3_input -> @test3_output" do
    assert HowManyNumbersAreSmallerThanTheCurrentNumber.go(@test3_input) == @test3_output
  end
  test "go2: @test3_input -> @test3_output" do
    assert HowManyNumbersAreSmallerThanTheCurrentNumber.go2(@test3_input) == @test3_output
  end

end

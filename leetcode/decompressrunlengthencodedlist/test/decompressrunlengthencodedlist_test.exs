defmodule DecompressRunLengthEncodedListTest do
  use ExUnit.Case
  doctest DecompressRunLengthEncodedList

  @test1_input [1, 2, 3, 4]
  @test1_output [2, 4, 4, 4]
  test "@test1_input -> @test1_output" do
    assert DecompressRunLengthEncodedList.go(@test1_input) == @test1_output
  end

  @test2_input [1, 1, 2, 3]
  @test2_output [1, 3, 3]
  test "@test2_input -> @test2_output" do
    assert DecompressRunLengthEncodedList.go(@test2_input) == @test2_output
  end

  @test3_input [4, 3, 1, 5, 3, 3, 5, 0]
  @test3_output [3, 3, 3, 3, 5, 3, 3, 3, 0, 0, 0, 0, 0]
  test "@test3_input -> @test3_output" do
    assert DecompressRunLengthEncodedList.go(@test3_input) == @test3_output
  end

end

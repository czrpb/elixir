defmodule FindLinesAfterTest do
  use ExUnit.Case
  doctest FindLinesAfter

  test "greets the world" do
    expected_lines = []
    assert FindLinesAfter.lines_after("**TODO:") == expected_lines
  end
end

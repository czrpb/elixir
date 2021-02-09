defmodule GoalParserInterpretationTest do
  use ExUnit.Case
  doctest GoalParserInterpretation

  test "greets the world" do
    input = "G()(al)"
    expected = "Goal"
    assert GoalParserInterpretation.interpret(input) == expected
  end
end

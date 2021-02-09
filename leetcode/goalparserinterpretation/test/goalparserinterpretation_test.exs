defmodule GoalParserInterpretationTest do
  use ExUnit.Case
  doctest GoalParserInterpretation

  test "'G()(al)' -> 'Goal'" do
    input = "G()(al)"
    expected = "Goal"
    assert GoalParserInterpretation.interpret(input) == expected
  end

  test "'G()()()()(al)' -> 'Gooooal'" do
    input = "G()()()()(al)"
    expected = "Gooooal"
    assert GoalParserInterpretation.interpret(input) == expected
  end

  test "'' -> ''" do
    input = "(al)G(al)()()G"
    expected = "alGalooG"
    assert GoalParserInterpretation.interpret(input) == expected
  end

end

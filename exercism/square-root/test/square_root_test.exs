defmodule SquareRootTest do
  use ExUnit.Case

  test "root of 152399025" do
    radicand = 152399025
    output = SquareRoot.calculate(radicand)
    expected = 12345
    assert output == expected
  end

  test "root of 2.3225462820950624e16" do
    radicand = 2.3225462820950624e16
    output = SquareRoot.calculate(radicand)
    expected = 152399025
    assert output == expected
  end

  # @tag :pending
  test "root of 1" do
    radicand = 1
    output = SquareRoot.calculate(radicand)
    expected = 1

    assert output == expected
  end

  #@tag :pending
  test "root of 4" do
    radicand = 4
    output = SquareRoot.calculate(radicand)
    expected = 2

    assert output == expected
  end

  #@tag :pending
  test "root of 25" do
    radicand = 25
    output = SquareRoot.calculate(radicand)
    expected = 5

    assert output == expected
  end

  #@tag :pending
  test "root of 81" do
    radicand = 81
    output = SquareRoot.calculate(radicand)
    expected = 9

    assert output == expected
  end

  #@tag :pending
  test "root of 196" do
    radicand = 196
    output = SquareRoot.calculate(radicand)
    expected = 14

    assert output == expected
  end

  #@tag :pending
  test "root of 65025" do
    radicand = 65025
    output = SquareRoot.calculate(radicand)
    expected = 255

    assert output == expected
  end
end

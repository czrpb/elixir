defmodule TelegramProblemTest do
  use ExUnit.Case
  doctest TelegramProblem

  test "basic hello world with len 5" do
    words = "basic hello world"
    max_length = 5
    expected = "basic\nhello\nworld"

    assert TelegramProblem.solve(words, max_length) == expected
  end

  test "basic hello world with len 11" do
    words = "basic hello world"
    max_length = 11
    expected = "basic hello\nworld"

    assert TelegramProblem.solve(words, max_length) == expected
  end

  test "basic hello world with len 7" do
    words = "basic hello world"
    max_length = 7
    expected = "basic\nhello\nworld"

    assert TelegramProblem.solve(words, max_length) == expected
  end

  test "basic hello world with len 15" do
    words = "basic hello world"
    max_length = 15
    expected = "basic hello\nworld"

    assert TelegramProblem.solve(words, max_length) == expected
  end

  test "basic hello world with len 16" do
    words = "basic hello world"
    max_length = 16
    expected = "basic hello\nworld"

    assert TelegramProblem.solve(words, max_length) == expected
  end

  test "basic hello world with len 17" do
    words = "basic hello world"
    max_length = 17
    expected = "basic hello world"

    assert TelegramProblem.solve(words, max_length) == expected
  end
end

defmodule LongestSubstrwoRepeatsTest do
  use ExUnit.Case
  doctest LongestSubstrwoRepeats

  defp check(input, expected) do
    assert LongestSubstrwoRepeats.longestsubstr(input) == expected
  end

  test "'abcabcbb' -> 3" do
    check("abcabcbb", 3)
  end

  test "'bbbbb' -> 1" do
    check("bbbbb", 1)
  end

  test "'pwwkew' -> 3" do
    check("pwwkew", 3)
  end

  test "'' -> 0" do
    check("", 0)
  end

end

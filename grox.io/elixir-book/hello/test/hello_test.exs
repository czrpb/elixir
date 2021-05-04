defmodule HelloTest do
  use ExUnit.Case
  doctest Hello

  test "greets the world" do
    assert Hello.hello() == :world
  end

  test "json hello world" do
    assert Hello.hello_json() == ~S<{"hello":"world"}>
  end
end

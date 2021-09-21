defmodule RPG.CharacterSheet do
  defstruct [:name, :class, :level]

  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  defp gets(prompt) do
    IO.gets(prompt) |> String.trim()
  end

  def ask_name() do
    gets("What is your character's name?\n")
  end

  def ask_class() do
    gets("What is your character's class?\n")
  end

  def ask_level() do
    gets("What is your character's level?\n") |> String.to_integer()
  end

  def run() do
    welcome()

    name = ask_name()
    class = ask_class()
    level = ask_level()

    %{:name => name, :class => class, :level => level}
    |> IO.inspect(label: "Your character")
  end
end

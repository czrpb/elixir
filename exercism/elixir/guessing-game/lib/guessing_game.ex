defmodule GuessingGame do
  def compare(secret, guess \\ :no_guess)

  def compare(secret, :no_guess), do: "Make a guess"

  def compare(guessed_correctly, guessed_correctly), do: "Correct"

  def compare(secret, guess)
  when (guess-1) == secret or secret == (guess+1) do
    "So close"
  end

  def compare(secret, guess)
  when secret < guess do
    "Too high"
  end
  def compare(secret, guess)
  when secret > guess do
    "Too low"
  end
end

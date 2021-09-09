defmodule SquareRoot do
  @moduledoc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    {sqrt, recursion_count} = guess(radicand, radicand/2)
    IO.puts("  >> To get sqrt(#{radicand}) -> #{sqrt}, we recursed #{recursion_count}times")
    sqrt
  end

  @doc """
  radicand - number to be square rooted
  guess    - current guess of the radicand's sqrt
  factor   - factor by which we modify our guess
             * our 1st guess is 1/2 the radicand, but as we refine our guesses
               by adding/subtracting to/from our guess we want to do so in
               smaller increments, thus `guess +/- (guess/2)` takes quite
               a bit of time to converge so instead we reduce our inc/dec
               by the number of times we have recursed
  error    - diff between radicand and guess^2
             * determines when we think our guess is "close enough"
  """
  def guess(radicand, guess, factor \\ 3, error \\ 1.0e-5) do
    guess_sqrd = guess*guess |> round
    #IO.puts("\n#{radicand}  #{guess}  #{error}  / #{guess_sqrd}  #{radicand-guess_sqrd}")
    cond do
      abs(radicand - guess_sqrd) <= error -> {guess |> round, factor-3}
      guess_sqrd < radicand -> guess(radicand, guess + (guess/factor), factor+1, error)
      true -> guess(radicand, guess - (guess/factor), factor+1, error)
    end
  end

end

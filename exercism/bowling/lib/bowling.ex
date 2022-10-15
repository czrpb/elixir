defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @type roll() :: integer | :x | nil
  @type frame() :: {integer, roll(), roll()}
  @type game() :: [frame()]

  @pincount {:error, "Pin count exceeds pins on the lane"}
  @negroll {:error, "Negative roll is invalid"}
  @incompletegame {:error, "Score cannot be taken until the end of the game"}
  @gameover {:error, "Cannot roll after game is over"}

  @spec start() :: any
  def start do
    [{1, nil, nil}]
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful error tuple.
  """

  @spec roll(game(), integer) :: {:ok, any} | {:error, String.t()}

  # handle 10th frame
  def roll([{10, nil, nil} | past_frames], roll) do
    cond do
      roll > 10 -> @pincount
      true -> {:ok, [{10, roll, nil, nil} | past_frames]}
    end
  end

  def roll([{10, a, nil, nil} | past_frames], roll) do
    cond do
      roll > 10 -> @pincount
      true -> {:ok, [{10, a, roll, nil} | past_frames]}
    end
  end

  def roll([{10, a, b, nil} | past_frames], roll) do
    cond do
      roll > 10 -> @pincount
      b < 10 and a+b != 10 and b+roll > 10 -> @pincount
      a+b < 10 -> @gameover
      true -> {:ok, [{10, a, b, roll} | past_frames]}
    end
  end

  # handle strike
  def roll([{fr_num, nil, nil} | past_frames], 10) do
    {:ok, [{fr_num + 1, nil, nil}, {fr_num, 10, 0} | past_frames]}
  end

  # handle 1st roll
  def roll([{fr_num, nil, nil} | past_frames], roll) do
    cond do
      roll > 10 -> @pincount
      roll < 0 -> @negroll
      true -> {:ok, [{fr_num, roll, nil} | past_frames]}
    end
  end

  # handle 2nd roll
  def roll([{fr_num, r, nil} | past_frames], roll) do
    if r + roll > 10 do
      @pincount
    else
      {:ok, [{fr_num + 1, nil, nil}, {fr_num, r, roll} | past_frames]}
    end
  end

  # handle too many rolls
  def roll(_, _) do
    @gameover
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful error tuple.
  """

  @spec score(any) :: {:ok, integer} | {:error, String.t()}

  def score(game) do
    cond do
      length(game) != 10 -> @incompletegame
      not match?({10, _, _, _}, hd(game)) -> @incompletegame
      true ->
        {10, a, b, c} = hd(game)
        cond do
          b == nil -> @incompletegame
          c == nil and a+b >= 10 -> @incompletegame
          true -> {:ok, score_p(game, {{0, 0}, 0})}
        end

    end
  end

  # handle 10th frame
  defp score_p([{10, a, b, c} | remaining], {_carry, _total}) do
    total = a + b + (c || 0)
    score_p(remaining, {{a, b}, total})
  end

  defp score_p([{_fr_num, a, b} | remaining], {{c1, c2}, total}) do
    {carry, total} =
      cond do
        # strike
        a == 10 ->
          {{a, c1}, total + a + c1 + c2}

        # spare
        a + b == 10 ->
          {{a, b}, total + a + b + c1}

        # open
        true ->
          {{a, b}, total + a + b}
      end

    score_p(remaining, {carry, total})
  end

  # # handle 2 strikes
  # defp score_p([{_fr_num1, 10, _} | [{_fr_num2, 10, _}, {_fr_num3, a, _} | _] = remaining], total) do
  #   score_p(remaining, total + 10 + 10 + a)
  # end

  # defp score_p([{_fr_num1, 10, _} | [{_fr_num2, a, b} | _] = remaining], total) do
  #   score_p(remaining, total + 10 + a + b)
  # end

  # # handle spare
  # defp score_p([{_fr_num1, a, b}, {_fr_num2, c, _} = f2 | remaining], total)
  #      when a + b == 10 do
  #   score_p([f2 | remaining], total + a + b + c)
  # end

  # # handle open
  # defp score_p([{_fr_num, a, b} | remaining], total) do
  #   score_p(remaining, total + a + b)
  # end

  defp score_p([], {_carry, total}), do: total
end

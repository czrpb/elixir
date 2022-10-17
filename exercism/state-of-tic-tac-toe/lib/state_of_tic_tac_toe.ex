defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """

  def winner(rows) do
    Enum.any?(
      rows,
      &(&1 in [["X", "X", "X"], ["O", "O", "O"]])
    )
  end

  def winning_row(board) do
    board
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))
    |> winner
  end

  def winning_column(board) do
    rows = String.split(board, "\n")

    0..2
    |> Enum.reduce([], fn col, acc ->
      [Enum.map(rows, &String.at(&1, col)) | acc]
    end)
    |> winner
  end

  def winning_diagonal(board) do
    rows = String.split(board, "\n")
    Enum.any?(
      Enum.map(["X", "O"], fn mark ->
        IO.inspect(mark, label: "mark")

        Enum.all?(
          Enum.zip(0..2, rows),
          fn {offset, row} ->
            Enum.at(row, offset) == mark
          end
        )
        |> tap(&IO.inspect/1)
      end)
    )
  end

  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    board = String.trim(board)

    wins =
      Enum.any?(
        [&winning_row/1, &winning_column/1, &winning_diagonal/1],
        fn f -> f.(board) end
      )

    case wins do
      true -> {:ok, :win}
      _ -> nil
    end
  end
end

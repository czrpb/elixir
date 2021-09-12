defmodule Chessboard do
  @rank_range 1..8
  @file_range ?A..?H

  def rank_range do
    @rank_range
  end

  def file_range do
    @file_range
  end

  def ranks do
    Enum.to_list(@rank_range)
  end

  def files do
    Enum.map(@file_range, &<<&1>>)
  end
end

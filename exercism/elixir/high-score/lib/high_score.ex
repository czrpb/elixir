defmodule HighScore do

  @initial 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @initial), do: Map.put(scores, name, score)

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name) do
    Map.update(scores, name, @initial, fn _ -> @initial end)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, &(&1+score))
  end

  def get_players(scores), do: Map.keys(scores)
end

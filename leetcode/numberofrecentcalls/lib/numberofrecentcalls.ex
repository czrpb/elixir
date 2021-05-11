defmodule NumberOfRecentCalls do
  use Agent

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def go(state, ping) do
    ping_range = ping - 3000 - 1
    count = state
    |> Enum.reduce_while(
      1,
      fn ping, count ->
        if ping > ping_range do
          {:cont, count+1}
        else
          {:halt, count}
        end
      end
    )
    {count, [ping|state]}
  end

  def ping(ping) do
    Agent.get_and_update(__MODULE__, __MODULE__, :go, [ping])
  end

  def state() do
    Agent.get(__MODULE__, &(&1))
  end
end

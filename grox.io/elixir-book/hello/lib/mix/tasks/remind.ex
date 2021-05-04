defmodule Mix.Tasks.Remind do
  use Mix.Task

  @shortdoc "Remind me of some useful commands"
  def run(_) do
    IO.puts("""
    mix remind    =>   this reminder of useful mix functionality
    iex -S mix    =>   start app in iex
    mix test      =>   run tests
    mix deps.get  =>   get project dependencies
    """)
  end

end

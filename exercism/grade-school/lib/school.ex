defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db, name, grade) do
    # if name in List.flatten(Map.values(db)) do
    #   db
    # else
    #   Map.update(db, grade, [name], &[name | &1])
    # end

    {db, _} =
      db
      # insert student
      |> Map.update(grade, [name], fn roster_ ->
        if name in roster_, do: roster_, else: [name | roster_]
      end)
      # remove student if inserted into multiple grades
      |> Enum.reverse()
      |> Enum.reduce({[], :not_seen}, fn
        {grade_, roster_} = grade_roster_, {db_, seen} ->
          case name in roster_ do
            true ->
              case seen do
                :not_seen -> {[grade_roster_ | db_], :seen}
                :seen -> {[{grade_, List.delete(roster_, name)} | db_], seen}
              end

            false ->
              {[grade_roster_ | db_], seen}
          end
      end)

    db
    # remove empty grades
    |> Enum.reject(fn
      {_, []} -> true
      _ -> false
    end)
    |> Map.new()
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    db |> Enum.sort() |> Enum.map(fn {g, r} -> {g, Enum.sort(r)} end)
  end
end

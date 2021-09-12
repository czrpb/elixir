defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @cup_to_plant %{
    ?R => :radishes,
    ?C => :clover,
    ?G => :grass,
    ?V => :violets
  }

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    info_string
    |> String.split("\n")
    # we have a list of 2 strings; ie: the rows

    |> Enum.map(&String.to_charlist/1)
    # turned them into charlists

    |> Enum.map(&Enum.chunk_every(&1, 2))
    # each charlist/row gets chunked into charlists of length 2

    |> Enum.zip()
    # zip up the chunks from row1 and row2; result is 2-tuple (row1 and row2) of 2-charlists

    |> Enum.map(fn {row1, row2} -> row1 ++ row2 end)
    # now have a list of cups from row1 and row2 together

    |> Stream.concat(Stream.cycle([[]]))
    # we need empty list cups for students that didnt plant

    |> Enum.zip(Enum.sort(student_names))
    # zip up the cups with students
    # result is a 2-tuple of list of cups and the students name

    |> Enum.into(%{}, fn {cups, student} ->
      {
        student,
        cups |> Enum.map(&@cup_to_plant[&1]) |> List.to_tuple()
        # turns each students cups into their plant names
      }
    end)
  end
end

defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}

  def convert(digits, input_base, output_base) do
    cond do
      output_base < 2 ->
        {:error, "output base must be >= 2"}

      input_base < 2 ->
        {:error, "input base must be >= 2"}

      Enum.reject(digits, &(0 <= &1 and &1 < input_base)) != [] ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        convert_by_output_base = &convert_output(output_base, &1)
        convert_input(digits, input_base) |> convert_by_output_base.()
    end
  end

  def convert_input(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {v, i} -> v * :math.pow(input_base, i) end)
    |> Enum.sum()
    |> round
  end

  def convert_output(output_base, value, result \\ [])

  def convert_output(output_base, value, result)
      when value < output_base do
    {:ok, [value | result]}
  end

  def convert_output(output_base, value, result) do
    convert_output(output_base, div(value, output_base), [rem(value, output_base) | result])
  end
end

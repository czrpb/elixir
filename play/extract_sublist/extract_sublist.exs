defmodule Extract do
  def extract(list, stop, start) do
    list
    |> Enum.reverse
    |> Enum.reduce_while(
      {:error, {false, []}},
      fn w, {_code, {capture, captured}}=acc ->
        cond do
          stop.(w) and capture -> {:halt, {:ok, [w|captured]}}
          start.(w) or capture -> {:cont, {:error, {true, [w|captured]}}}
          true -> {:cont, acc}
        end
      end
    )
  end
end


input = ~W<this is a test to see if i can figure out how to extract the text i want easily>
expected1 = ~W<can figure out how to extract the text>
expected2 = ~W<if i can figure out how to extract the text>

#result = input |> Extract.extract(["if", "can"], ["text"])
result = input
|> Extract.extract(&Regex.match?(~R<^if|can$>, &1), &Regex.match?(~R<^text$>, &1))

status = case result do
  {:ok, result} -> result in [expected1, expected2]
  {:error, {_, partial}} -> partial
end

case status do
  true -> IO.puts("PASSED")
  [] -> IO.puts("FAILED to find ending RE (dont know about starting)")
  status -> IO.puts("FAILED to find starting RE: Got #{status |> inspect}")
end

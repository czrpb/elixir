defmodule LinkedList do
  @opaque t :: tuple()

  @ll {}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    @ll
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {elem, list}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    length(list, 0)
  end
  defp length(@ll, l), do: l
  defp length({_elem, next}, l), do: length(next, l+1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    list == @ll
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(@ll), do: {:error, :empty_list}
  def peek({head, _tail}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(@ll), do: {:error, :empty_list}
  def tail({_head, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(@ll), do: {:error, :empty_list}
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    from_list(Enum.reverse(list), new())
  end
  defp from_list([], ll), do: ll
  defp from_list([h|t], ll), do: from_list(t, push(ll, h))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    to_list(list, [])
  end
  defp to_list(@ll, ll), do: Enum.reverse(ll)
  defp to_list({head, tail}, ll), do: to_list(tail, [head|ll])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    reverse(list, new())
  end
  defp reverse(@ll, ll), do: ll
  defp reverse({head, tail}, ll), do: reverse(tail, push(ll, head))
end

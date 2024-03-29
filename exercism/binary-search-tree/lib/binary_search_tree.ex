defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, newdata), do: new(newdata)

  def insert(%{data: data, left: left} = tree, newdata)
      when newdata <= data do
    %{tree | left: insert(left, newdata)}
  end

  def insert(%{data: data, right: right} = tree, newdata)
      when data < newdata do
    %{tree | right: insert(right, newdata)}
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(%{data: data, left: left, right: right}) do
    in_order(left) ++ [data] ++ in_order(right)
  end
end

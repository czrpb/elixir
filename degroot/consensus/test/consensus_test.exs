defmodule ConsensusTest do
  use ExUnit.Case
  doctest Consensus

  test "create a matrix" do
    l = [[1/2, 1/4, 1/4], [1/3, 1/3, 1/3], [0, 1/4, 3/4]]
    m = Consensus.list_to_matrix(l)
    assert m == l
  end

  test "multiply a matrix by identity" do
    l = [[1/2, 1/4, 1/4], [1/3, 1/3, 1/3], [0, 1/4, 3/4]]
    m = Consensus.list_to_matrix(l)
    assert Matrix.mult(m, Matrix.ident(3)) == l
  end

  test "multiply a matrix by [1,1,1]" do
    #l = [[1/2, 1/4, 1/4], [1/3, 1/3, 1/3], [0, 1/4, 3/4]]
    #l = [[3/4, 1/8, 1/8], [1/8, 3/4, 1/8], [1/8, 1/8, 3/4]]
    #l = [[3/4, 1/8, 1/8], [0, 3/4, 1/4], [0, 3/4, 1/4]]
    beliefs = [[1/5, 1/5, 1/5, 1/5, 1/5]]
    l = [
      [0,   1/4, 1/4, 1/4, 1/4],
      [0,   1/2, 1/2,   0,   0],
      [0,   1/2, 1/2,   0,   0],
      [0,     0,   0, 1/2, 1/2],
      [0,     0,   0, 1/2, 1/2]
    ]
    #beliefs = [[1/3,1/3,1/3]]
    #l = [
    #  [0, 1/2, 1/2],
    #  [0, 1/2, 1/2],
    #  [0, 1/2, 1/2]
    #]
    IO.puts("#{inspect(beliefs)}")
    m = Consensus.list_to_matrix(l)
    Enum.reduce_while(
      0..1000,
      beliefs,
      fn iteration, beliefs ->
        new_beliefs = Matrix.mult(beliefs, m)
        IO.puts("#{iteration} : #{inspect(new_beliefs)}")
        {
          (Matrix.almost_equal(beliefs, new_beliefs, 0.0001) and :halt) or :cont,
          new_beliefs
        }
      end
    )
    assert 0 == 1
  end
end

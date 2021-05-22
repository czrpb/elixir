defmodule TreeInsertBFTest do
  use ExUnit.Case
  doctest TreeInsertBF

  test "make tree for: [1, 2, 3]" do
    input = 1..3 |> Enum.to_list
    [root | rest] = input

    expected = {{nil, 2, nil}, 1, {nil, 3, nil}}

    assert TreeInsertBF.insert_left_into_tree(root, rest) == expected
  end

  test "make tree for: [1, 2, 3, 4, 5, 6]" do
    input = 1..6 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {{nil, 6, nil}, 4, nil},
        2,
        {nil, 5, nil}
      },
      1,
      {nil, 3, nil}
    }

    assert TreeInsertBF.insert_left_into_tree(root, rest) == expected
  end

  test "make tree for: [1, 2, 3, 4, 5, 6, 7, 8, 9]" do
    input = 1..9 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {
          {
            {
              nil,
              8,
              nil
            },
            6,
            {nil, 9, nil}
          },
          4,
          {nil, 7, nil}
        },
        2,
        {nil, 5, nil}
      },
      1,
      {nil, 3, nil}
    }

    assert TreeInsertBF.insert_left_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1]" do
    input = 1..1 |> Enum.to_list
    [root | rest] = input

    expected = {{nil, 1, nil}, {0, 0}}

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2]" do
    input = 1..2 |> Enum.to_list
    [root | rest] = input

    expected = {
      {{{nil, 2, nil}, {0, 0}}, 1, nil},
      {1, 0}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3]" do
    input = 1..3 |> Enum.to_list
    [root | rest] = input

    expected = {
      {{{nil, 2, nil}, {0, 0}}, 1, {{nil, 3, nil}, {0,0}}},
      {1, 1}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3, 4]" do
    input = 1..4 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {{{{nil, 4, nil}, {0, 0}}, 2, nil}, {1, 0}},
        1,
        {{nil, 3, nil}, {0, 0}}
      },
      {2, 1}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3, 4, 5]" do
    input = 1..5 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {{{{nil, 4, nil}, {0, 0}}, 2, nil}, {1, 0}},
        1,
        {{{{nil, 5, nil}, {0, 0}}, 3, nil}, {1, 0}}
      },
      {2, 2}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3, 4, 5, 6]" do
    input = 1..6 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {{{{nil, 4, nil}, {0, 0}}, 2, {{nil, 6, nil}, {0, 0}}}, {1, 1}},
        1,
        {{{{nil, 5, nil}, {0, 0}}, 3, nil}, {1, 0}}
      },
      {3, 2}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3, 4, 5, 6, 7]" do
    input = 1..7 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {
          {{{nil, 4, nil}, {0, 0}}, 2, {{nil, 6, nil}, {0, 0}}},
          {1, 1}
        },
        1,
        {
          {{{nil, 5, nil}, {0, 0}}, 3, {{nil, 7, nil}, {0, 0}}},
          {1, 1}
        }
      },
      {3, 3}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3, 4, 5, 6, 7, 8]" do
    input = 1..8 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {
          {
            {{{{nil, 8, nil}, {0, 0}}, 4, nil}, {1, 0}},
            2,
            {{nil, 6, nil}, {0, 0}}
          },
          {2, 1}
        },
        1,
        {{{{nil, 5, nil}, {0, 0}}, 3, {{nil, 7, nil}, {0, 0}}}, {1, 1}}
      },
      {4, 3}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end

  test "make balanced tree for: [1, 2, 3, 4, 5, 6, 7, 8, 9]" do
    input = 1..9 |> Enum.to_list
    [root | rest] = input

    expected = {
      {
        {
          {
            {{{{nil, 8, nil}, {0, 0}}, 4, nil}, {1, 0}},
            2,
            {{nil, 6, nil}, {0, 0}}
          },
          {2, 1}
        },
        1,
        {
          {
            {{{{nil, 9, nil}, {0, 0}}, 5, nil}, {1, 0}},
            3,
            {{nil, 7, nil}, {0, 0}}
          },
          {2, 1}}
      },
      {4, 4}
    }

    assert TreeInsertBF.insert_bf_into_tree(root, rest) == expected
  end
end

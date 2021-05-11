defmodule MaximumDepthOfBinaryTreeTest do
  use ExUnit.Case
  doctest MaximumDepthOfBinaryTree

  test "greets the world" do
    assert MaximumDepthOfBinaryTree.hello() == :world
  end

  describe "recursive solution" do

    test "empty/nil tree" do
      tree = nil
      assert MaximumDepthOfBinaryTree.depth_via_recursion(tree) == 0
    end

    test "root only tree" do
      tree = {nil, :value, nil}
      assert MaximumDepthOfBinaryTree.depth_via_recursion(tree) == 1
    end

    test "left leaning" do
      tree = {
        {
          {nil, :value, nil},
          :value,
          nil
        },
        :value,
        nil
      }
      assert MaximumDepthOfBinaryTree.depth_via_recursion(tree) == 3
    end
    test "right leaning" do
      tree = {
        nil,
        :value,
        {
          {nil, :value, nil},
          :value,
          nil
        },
      }
      assert MaximumDepthOfBinaryTree.depth_via_recursion(tree) == 3
    end
    test "balanced" do
      tree = {
        {nil, :value, nil},
        :value,
        {nil, :value, nil}
      }
      assert MaximumDepthOfBinaryTree.depth_via_recursion(tree) == 2
    end

    test "example1" do
      tree = {
        {nil, 9, nil},
        3,
        {
          {nil, 15, nil},
          20,
          {nil, 7, nil}
        }
      }
      assert MaximumDepthOfBinaryTree.depth_via_recursion(tree) == 3
    end
  end

  describe "iterative solution" do

    test "empty/nil tree" do
      tree = nil
      assert MaximumDepthOfBinaryTree.depth_via_iteration(tree) == 0
    end

    test "root only tree" do
      tree = {nil, :value, nil}
      assert MaximumDepthOfBinaryTree.depth_via_iteration(tree) == 1
    end

    test "left leaning" do
      tree = {
        {
          {nil, :value, nil},
          :value,
          nil
        },
        :value,
        nil
      }
      assert MaximumDepthOfBinaryTree.depth_via_iteration(tree) == 3
    end
    test "right leaning" do
      tree = {
        nil,
        :value,
        {
          {nil, :value, nil},
          :value,
          nil
        },
      }
      assert MaximumDepthOfBinaryTree.depth_via_iteration(tree) == 3
    end
    test "balanced" do
      tree = {
        {nil, :value, nil},
        :value,
        {nil, :value, nil}
      }
      assert MaximumDepthOfBinaryTree.depth_via_iteration(tree) == 2
    end

    test "example1" do
      tree = {
        {nil, 9, nil},
        3,
        {
          {nil, 15, nil},
          20,
          {nil, 7, nil}
        }
      }
      assert MaximumDepthOfBinaryTree.depth_via_iteration(tree) == 3
    end
  end

end
